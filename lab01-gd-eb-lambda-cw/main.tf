provider "aws" {
  region = "us-east-1"
}

resource "aws_guardduty_detector" "main" {
  enable = true
}

resource "aws_iam_role" "lambda_exec" {
  name = "gd_lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_permissions" {
  name        = "gd_lambda_policy"
  description = "Allow logging and EC2 describe for GuardDuty Lambda"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeInstances"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_permissions.arn
}

resource "aws_lambda_function" "gd_logger" {
  function_name = "GuardDutyLogger"
  filename         = "${path.module}/lambda/gd_lambda.zip"
  handler          = "gd_lambda.lambda_handler"
  runtime          = "python3.12"
  role             = aws_iam_role.lambda_exec.arn
  source_code_hash = filebase64sha256("${path.module}/lambda/gd_lambda.zip")
}

resource "aws_cloudwatch_event_rule" "gd_findings" {
  name        = "guardduty-findings"
  description = "Trigger Lambda on GuardDuty port scan"

  event_pattern = jsonencode({
    source = ["aws.guardduty"],
    "detail-type" = ["GuardDuty Finding"],
    detail = {
      type = ["Recon:EC2/Portscan"]
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.gd_findings.name
  target_id = "SendToLambda"
  arn       = aws_lambda_function.gd_logger.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.gd_logger.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.gd_findings.arn
}

output "guardduty_detector_id" {
  value = aws_guardduty_detector.main.id
}

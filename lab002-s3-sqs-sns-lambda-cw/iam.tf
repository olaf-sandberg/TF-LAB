resource "aws_iam_role" "lambda_exec" {
  name = "lab002-s3-sqs-sns-lambda-cw-role"

  assume_role_policy = data.aws_iam_policy_document.lambda_trust.json
}

data "aws_iam_policy_document" "lambda_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lab002-s3-sqs-sns-lambda-cw-policy"
  role = aws_iam_role.lambda_exec.id

  policy = data.aws_iam_policy_document.lambda_policy_doc.json
}

data "aws_iam_policy_document" "lambda_policy_doc" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]

    resources = ["*"]
  }
}

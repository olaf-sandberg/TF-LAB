resource "aws_lambda_function" "s3_event_logger" {
  function_name = "lab002-s3-sqs-sns-lambda-cw-function"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.12"

  filename         = "lambda_function_payload.zip"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")

  depends_on = [aws_iam_role_policy.lambda_policy]
}

resource "aws_lambda_event_source_mapping" "from_sqs" {
  event_source_arn = aws_sqs_queue.file_events_queue.arn
  function_name    = aws_lambda_function.s3_event_logger.arn
  batch_size       = 1
}

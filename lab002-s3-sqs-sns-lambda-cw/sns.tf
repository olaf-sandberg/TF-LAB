resource "aws_sns_topic" "file_upload_topic" {
  name = "lab002-s3-sqs-sns-lambda-cw-topic"
}

resource "aws_sns_topic_subscription" "sqs_subscription" {
  topic_arn = aws_sns_topic.file_upload_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.file_events_queue.arn
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.file_upload_topic.arn
  protocol  = "email"
  endpoint  = "sandberg.olaf@gmail.com"
}

resource "aws_sns_topic_policy" "allow_s3_publish" {
  arn    = aws_sns_topic.file_upload_topic.arn
  policy = data.aws_iam_policy_document.s3_publish_policy.json
}

data "aws_iam_policy_document" "s3_publish_policy" {
  statement {
    actions = ["sns:Publish"]

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    resources = [aws_sns_topic.file_upload_topic.arn]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }
}

data "aws_caller_identity" "current" {}

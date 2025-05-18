resource "aws_sqs_queue" "file_events_queue" {
  name = "lab002-s3-sqs-sns-lambda-cw-queue"
}

resource "aws_sqs_queue_policy" "sns_to_sqs_policy" {
  queue_url = aws_sqs_queue.file_events_queue.id
  policy    = data.aws_iam_policy_document.sns_to_sqs.json
}

data "aws_iam_policy_document" "sns_to_sqs" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }

    actions = ["sqs:SendMessage"]

    resources = [aws_sqs_queue.file_events_queue.arn]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_sns_topic.file_upload_topic.arn]
    }
  }
}

resource "aws_s3_bucket" "event_bucket" {
  bucket = "lab002-s3-sqs-sns-lambda-cw-bucket"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.event_bucket.id

  topic {
    topic_arn = aws_sns_topic.file_upload_topic.arn
    events    = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_sns_topic_policy.allow_s3_publish]
}
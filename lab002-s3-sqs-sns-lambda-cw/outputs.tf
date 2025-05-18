output "s3_bucket_name" {
  value = aws_s3_bucket.event_bucket.bucket
}

output "sns_topic_arn" {
  value = aws_sns_topic.file_upload_topic.arn
}

output "sqs_queue_url" {
  value = aws_sqs_queue.file_events_queue.id
}

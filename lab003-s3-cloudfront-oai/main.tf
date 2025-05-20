provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "lab003" {
  bucket = var.bucket_name
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "lab003" {
  bucket = aws_s3_bucket.lab003.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_cloudfront_origin_access_identity" "lab003" {
  comment = "OAI for Lab 003"
}

data "aws_iam_policy_document" "lab003_policy" {
  statement {
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.lab003.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.lab003.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "lab003" {
  bucket = aws_s3_bucket.lab003.id
  policy = data.aws_iam_policy_document.lab003_policy.json
}

resource "aws_cloudfront_distribution" "lab003" {
  origin {
    domain_name = aws_s3_bucket.lab003.bucket_regional_domain_name
    origin_id   = "s3-${aws_s3_bucket.lab003.id}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.lab003.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-${aws_s3_bucket.lab003.id}"

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name = "lab003-cf"
  }
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.lab003.id
  key          = "index.html"
  content      = "<html><body><h1>Hello from Lab 003</h1></body></html>"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.lab003.id
  key          = "error.html"
  content      = "<html><body><h1>Something went wrong</h1></body></html>"
  content_type = "text/html"
}

#cria um bucket público para hospedagem de site estético

resource "aws_s3_bucket" "exemplo" {
  bucket = "bucket-name-terraform-site"
}

resource "aws_s3_bucket_public_access_block" "exemplo" {
  bucket = aws_s3_bucket.exemplo.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "exemplo" {
  bucket = aws_s3_bucket.exemplo.id
  policy = data.aws_iam_policy_document.exemplo.json
}

data "aws_iam_policy_document" "exemplo" {
  depends_on = [ 
    aws_s3_bucket.exemplo,
    aws_s3_bucket_public_access_block.exemplo
  ]    

  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.exemplo.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "exemplo" {
  bucket = aws_s3_bucket.exemplo.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "exemplo" {
  bucket = aws_s3_bucket.exemplo.id
  key    = "index.html" 
  source = "./site/index.html" 

  content_type = "text/html"
}
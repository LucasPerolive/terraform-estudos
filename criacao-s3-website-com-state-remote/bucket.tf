# Cria um bucket, configura ele para ser público e hospedar site estático.

# Cria um bucket
resource "aws_s3_bucket" "exemplo" {
  bucket = "bucket-name-terraform-site"
}

# Configura o bucket para ser público
resource "aws_s3_bucket_public_access_block" "exemplo" {
  bucket = aws_s3_bucket.exemplo.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Integra policy no S3
resource "aws_s3_bucket_policy" "exemplo" {
  bucket = aws_s3_bucket.exemplo.id
  policy = data.aws_iam_policy_document.exemplo.json
}

# Criação da policy
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

# Configura o WebSite para ser acessar o index.html
resource "aws_s3_bucket_website_configuration" "exemplo" {
  bucket = aws_s3_bucket.exemplo.id

  index_document {
    suffix = "index.html"
  }
}

# Faz upload do site para o bucket
resource "aws_s3_object" "exemplo" {
  bucket = aws_s3_bucket.exemplo.id
  key    = "index.html" 
  source = "./site/index.html" 

  content_type = "text/html"
}

# S3 Bucket storing logs

resource "aws_s3_bucket" "simple-web-app-logs" {
  bucket = "s3-for-simple-web-app-logs"
}

# S3 Bucket storing jenkins user data

resource "aws_s3_bucket" "jenkins-config" {
  bucket = "s3-for-jenkins-config"
}

# To upload all the config files in the folder jenkins-config

resource "aws_s3_object" "jenkins-config" {
  bucket = aws_s3_bucket.jenkins-config.id
  for_each = fileset("jenkins-config/", "*")
  key = each.value
  source = "jenkins-config/${each.value}"
  etag = filemd5("jenkins-config/${each.value}")
}
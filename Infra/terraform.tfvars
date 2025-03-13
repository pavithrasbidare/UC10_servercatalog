account_id           = "302263075199"
portfolio_name       = "hello-world"
portfolio_description = "This is a portfolio for managing service catalog products."
provider_name        = "IT (it@example.com)"
distributor_name     = "hello-world"
support_email        = "ITSupport@example.com"
support_url          = "https://wiki.example.com/IT/support"
iam_group_arn        = "arn:aws:iam::302263075199:group/Endusers"

products = [
  {
    product_name        = "Webapp"
    product_owner       = "IT"
    product_description = "Simple S3 bucket"
    artifact_version    = "v1.0"
    template_url        = "https://service-catalog-terraform.s3.us-west-1.amazonaws.com/service-catalog.tar.gz"
  }
]

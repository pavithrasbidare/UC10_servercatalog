account_id           = "302263075199"
portfolio_name       = "S3 bucket-terraform"
portfolio_description = "This is a portfolio for managing service catalog products."
provider_name        = "IT (it@example.com)"
#distributor_name     = "MyDistributor"
support_email        = "ITSupport@example.com"
support_url          = "https://wiki.example.com/IT/support"
iam_group_arn        = "arn:aws:iam::302263075199:group/Endusers"

products = [
  {
    product_name        = "Simple S3 bucket terraform"
    product_owner       = "IT"
    #product_description = "Simple S3 bucket"
    artifact_version    = "v1.0"
    template_url        = "https://s3.amazonaws.com/mybucket/product1-template.json"
  }
]

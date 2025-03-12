module "iam" {
  source = "../Modules/IAM"

  account_id = var.account_id
}

module "service_catalog" {
  source = "../Modules/Service-catalog"

  portfolio_name        = var.portfolio_name
  portfolio_description = var.portfolio_description
  provider_name         = var.provider_name
  #distributor_name      = var.distributor_name
  support_email         = var.support_email
  support_url           = var.support_url
  launch_role_arn       = module.iam.launch_role_arn
  iam_group_arn         = var.iam_group_arn
  products              = var.products
}

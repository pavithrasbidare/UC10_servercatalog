variable "account_id" {
  description = "The AWS account ID"
}

variable "portfolio_name" {
  description = "The name of the Service Catalog portfolio"
}

variable "portfolio_description" {
  description = "The description of the Service Catalog portfolio"
}

variable "provider_name" {
  description = "The name of the provider"
}

variable "distributor_name" {
  description = "The name of the distributor"
}

variable "support_email" {
  description = "The support email for the products"
}

variable "support_url" {
  description = "The support URL for the products"
}

variable "iam_group_arn" {
  description = "The ARN of the IAM group with access to the portfolio"
}

variable "products" {
  description = "The list of products to be added to the Service Catalog portfolio"
  type = list(object({
    product_name       : string,
    product_owner      : string,
    product_description: string,
    artifact_version   : string,
    template_url       : string,
  }))
}

variable "launch_role_arn" {
  description = "The ARN of the launch role"
  type        = string
}

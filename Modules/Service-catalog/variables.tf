variable "portfolio_name" {}
variable "portfolio_description" {}
variable "provider_name" {}
#variable "distributor_name" {}
variable "support_email" {}
variable "support_url" {}
variable "launch_role_arn" {}
variable "iam_group_arn" {}

variable "products" {
  type = list(object({
    product_name       : string,
    product_owner      : string,
    #product_description: string,
    artifact_version   : string,
    template_url       : string,
  }))
}

resource "aws_servicecatalog_portfolio" "portfolio" {
  name          = var.portfolio_name
  description   = var.portfolio_description
  provider_name = var.provider_name
}

resource "aws_servicecatalog_product" "products" {
  count         = length(var.products)
  name          = var.products[count.index].product_name
  owner         = var.products[count.index].product_owner
  description   = var.products[count.index].product_description
  distributor   = var.distributor_name
  support_email = var.support_email
  support_url   = var.support_url
  type          = "EXTERNAL"

  provisioning_artifact_parameters {
    name                         = var.products[count.index].artifact_version
    description                  = "Initial version"
    type                         = "EXTERNAL"  # Ensure this is set to EXTERNAL
    template_url                 = var.products[count.index].template_url
    disable_template_validation  = true
  }
}

resource "aws_servicecatalog_product_portfolio_association" "product_association" {
  count        = length(var.products)
  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = aws_servicecatalog_product.products[count.index].id
}

resource "aws_servicecatalog_principal_portfolio_association" "portfolio_access_group" {
  portfolio_id   = aws_servicecatalog_portfolio.portfolio.id
  principal_arn  = var.iam_group_arn
}

resource "aws_servicecatalog_constraint" "launch_constraint" {
  count        = length(var.products)
  portfolio_id = aws_servicecatalog_portfolio.portfolio.id
  product_id   = aws_servicecatalog_product.products[count.index].id
  type         = "LAUNCH"

  parameters = jsonencode({
    RoleArn = var.launch_role_arn
  })
}

output "portfolio_id" {
  description = "The ID of the Service Catalog portfolio"
  value       = aws_servicecatalog_portfolio.portfolio.id
}

output "product_ids" {
  description = "The IDs of the Service Catalog products"
  value       = [for product in aws_servicecatalog_product.products : product.id]
}

output "portfolio_product_associations" {
  description = "The associations between the portfolio and products"
  value       = [for assoc in aws_servicecatalog_product_portfolio_association.product_association : {
    portfolio_id = assoc.portfolio_id,
    product_id   = assoc.product_id
  }]
}

output "portfolio_access_group" {
  description = "The ARN of the IAM group with access to the portfolio"
  value       = aws_servicecatalog_principal_portfolio_association.portfolio_access_group.principal_arn
}

resource "aws_iam_policy" "service_catalog_policy" {
  name        = "ServiceCatalogPolicy"
  description = "Policy for AWS Service Catalog to manage resources"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect: "Allow",
        Action: "*",
        Resource: "*"
      }
    ]
  })
}

resource "aws_iam_role" "launch_role" {
  name = "SCLaunch-HelloWorld"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Principal: {
          Service: "servicecatalog.amazonaws.com"
        },
        Action: "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "launch_role_policy_attachment" {
  role       = aws_iam_role.launch_role.name
  policy_arn = aws_iam_policy.service_catalog_policy.arn
}

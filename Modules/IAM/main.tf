/*resource "aws_iam_policy" "service_catalog_policy" {
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
}*/

provider "aws" {
  region = "us-west-1"
}

resource "aws_iam_policy" "ec2_servicecatalog_policy" {
  name        = "hello-world"
  description = "Policy to allow Service Catalog to create EC2 instances, access S3 artifacts, and manage resources"
  policy      = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2:*",
            "Resource": "*"
        },
        {
            "Sid": "AllowS3AccessForServiceCatalogProvisioning",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "s3:ExistingObjectTag/servicecatalog:provisioning": "true"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::*"
            ]
        },
        {
            "Sid": "AllowResourceGroupManagement",
            "Effect": "Allow",
            "Action": [
                "resource-groups:CreateGroup",
               -groups:ListGroupResources",
                "resource-groups:DeleteGroup",
                "resource-groups:Tag",
                "resource-groups:Untag"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowTaggingPermissions",
            "Effect": "Allow",
            "Action": [
                "tag:GetResources",
                "tag:GetTagKeys",
                "tag:GetTagValues",
                "tag:TagResources",
                "tag:UntagResources"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_iam_role" "launch_role" {
  name = "SCLaunch-HelloWorld"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
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
  policy_arn = aws_iam_policy.ec2_servicecatalog_policy.arn
}

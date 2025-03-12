resource "aws_iam_policy" "s3_resource_creation_and_artifact_access" {
  name        = "S3ResourceCreationAndArtifactAccessPolicy"
  description = "Policy for S3 resource creation and artifact access for AWS Service Catalog"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid: "VisualEditor0",
        Effect: "Allow",
        Action: "s3:GetObject",
        Resource: "*",
        Condition: {
          StringEquals: {
            "s3:ExistingObjectTag/servicecatalog:provisioning": "true"
          }
        }
      },
      {
        Action: [
          "s3:CreateBucket*",
          "s3:DeleteBucket*",
          "s3:Get*",
          "s3:List*",
          "s3:PutBucketTagging"
        ],
        Resource: "arn:aws:s3:::*",
        Effect: "Allow"
      },
      {
        Action: [
          "resource-groups:CreateGroup",
          "resource-groups:ListGroupResources",
          "resource-groups:DeleteGroup",
          "resource-groups:Tag"
        ],
        Resource: "*",
        Effect: "Allow"
      },
      {
        Action: [
          "tag:GetResources",
          "tag:GetTagKeys",
          "tag:GetTagValues",
          "tag:TagResources",
          "tag:UntagResources"
        ],
        Resource: "*",
        Effect: "Allow"
      }
    ]
  })
}

resource "aws_iam_role" "launch_role" {
  name = "SCLaunch-S3product"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Sid: "GivePermissionsToServiceCatalog",
        Effect: "Allow",
        Principal: {
          Service: "servicecatalog.amazonaws.com"
        },
        Action: "sts:AssumeRole"
      },
      {
        Effect: "Allow",
        Principal: {
          AWS: "arn:aws:iam::${var.account_id}:root"
        },
        Action: "sts:AssumeRole",
        Condition: {
          StringLike: {
            "aws:PrincipalArn": [
              "arn:aws:iam::${var.account_id}:role/TerraformEngine/TerraformExecutionRole*",
              "arn:aws:iam::${var.account_id}:role/TerraformEngine/ServiceCatalogExternalParameterParserRole*",
              "arn:aws:iam::${var.account_id}:role/TerraformEngine/ServiceCatalogTerraformOSParameterParserRole*"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "launch_role_policy_attachment" {
  role       = aws_iam_role.launch_role.name
  policy_arn = aws_iam_policy.s3_resource_creation_and_artifact_access.arn
}

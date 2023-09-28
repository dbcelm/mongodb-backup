## This will create IAM Role for Service Account to be used by MongoDB Backup Service Account to authenticate to Backup S3 bucket

variable "namespace" {
  description = "MongoDB Namespace name"
  type        = string
  default     = "mongodb"
}

variable "service_account" {
  description = "MongoDB Backup Service Account Name"
  type        = string
  default     = "mongodb-backup-sa"
}

variable "irsa_iam_role_path" {
  description = "IAM role path for IRSA roles"
  type        = string
  default     = "/"
}

variable "irsa_iam_permissions_boundary" {
  description = "IAM permissions boundary for IRSA roles"
  type        = string
  default     = ""
}

variable "eks_oidc_provider_arn" {
  description = "EKS OIDC Provider ARN e.g., arn:aws:iam::<ACCOUNT-ID>:oidc-provider/<var.eks_oidc_provider>"
  type        = string
  default     = ""
}

locals {
  eks_oidc_issuer_url = replace(var.eks_oidc_provider_arn, "/^(.*provider/)/", "")
}


resource "aws_iam_policy" "iam_policy_mongo_irsa" {
  name        = "mongodb-backup-irsa-iam-policy"
  description = "Allows access to s3 from mongodb backup jobs"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Action": [
          "s3:ListAllMyBuckets"
        ],
        "Effect": "Allow",
        "Resource": "*",
        "Sid": "VisualEditor1"
      },
      {
        "Action": [
            "s3:PutObject",
            "s3:GetObject",
            "s3:ListBucket",
            "s3:DeleteObject",
            "s3:*Object"
        ],
        "Effect": "Allow",
        "Resource": [
            "arn:aws:s3:::s3-mongodb-backup/*",
            "arn:aws:s3:::s3-mongodb-backup"
        ],
        "Sid": "VisualEditor0"
      }
    ]
  })

  tags = {
    Purpose = "mongodb-backups"
  }
}

# NOTE: Don't change the condition from StringLike to StringEquals.
resource "aws_iam_role" "iam_role_mongo_irsa" {

  name        = "mongodb-backup-irsa-iam-role"
  description = "AWS IAM Role for the Kubernetes service account ${var.service_account}."
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : var.eks_oidc_provider_arn
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringLike" : {
            "${local.eks_oidc_issuer_url}:sub" : "system:serviceaccount:${var.namespace}:${var.service_account}",
            "${local.eks_oidc_issuer_url}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
  path                  = var.irsa_iam_role_path
  force_detach_policies = true
  permissions_boundary  = var.irsa_iam_permissions_boundary

}

resource "aws_iam_role_policy_attachment" "irsa" {
  policy_arn = aws_iam_policy.iam_policy_mongo_irsa.arn
  role       = aws_iam_role.iam_role_mongo_irsa.name
}
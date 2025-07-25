data "aws_caller_identity" "current" {}

resource "aws_eks_cluster" "this" {
  name     = "${var.env}-${var.project}-eks-cluster"
  role_arn = aws_iam_role.eks-cluster.arn
  version  = "1.32"

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    subnet_ids = var.aws_subnet_private_ids[*]
  }

  encryption_config {
    provider {
      key_arn = "arn:aws:kms:us-east-1:${data.aws_caller_identity.current.account_id}:alias/eks/mprofile/us-east-1"
    }
    resources = ["secrets"]
  }


  depends_on = [
    aws_iam_role_policy_attachment.amazon-eks-cluster-policy
  ]
}
resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "general"
  node_role_arn   = aws_iam_role.eks-node.arn
  subnet_ids = var.aws_subnet_private_ids[*]

  instance_types = ["t3.small"]
  capacity_type  = "ON_DEMAND"

  labels = {
    Type = "general"
  }

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon-ec2-container-registry-pull-only,
    aws_iam_role_policy_attachment.amazon-eks-cni-policy,
    aws_iam_role_policy_attachment.amazon-eks-worker-node-policy,
  ]
}
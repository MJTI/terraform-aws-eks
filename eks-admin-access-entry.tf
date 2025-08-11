resource "aws_eks_access_entry" "cluster-admin-access" {
  count = length(var.cluster_admin_access)

  cluster_name  = aws_eks_cluster.this.name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.cluster_admin_access[count.index]}"

  depends_on = [aws_eks_node_group.small-nodes]
}

resource "aws_eks_access_policy_association" "cluster-admin-association" {
  count = length(var.cluster_admin_access)

  cluster_name  = aws_eks_cluster.this.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.cluster_admin_access[count.index]}"

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.cluster-admin-access]
}
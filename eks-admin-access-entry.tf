resource "aws_eks_access_entry" "cluster-admin-access" {
  count = length(var.cluster_admin_access)

  cluster_name      = aws_eks_cluster.this.name
  principal_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.cluster_admin_access[count.index]}"
  kubernetes_groups = ["${var.project}-admin"]

  depends_on = [aws_eks_node_group.small-nodes]
}
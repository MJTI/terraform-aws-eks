resource "kubernetes_cluster_role_binding_v1" "eks-admin-role-binding" {
  metadata {
    name = "admin-cluster-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Group"
    name      = "${var.project}-admin"
    namespace = ""
  }
}

resource "aws_eks_access_entry" "cluster-admin-access" {
  count = length(var.cluster_admin_access)

  cluster_name      = aws_eks_cluster.this.name
  principal_arn     = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.cluster_admin_access[count.index]}"
  kubernetes_groups = ["${var.project}-admin"]
}
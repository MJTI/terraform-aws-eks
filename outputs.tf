data "aws_eks_cluster" "eks-cluster" {
    name = aws_eks_cluster.this.name
}

output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_security_group_id" {
  value = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

output "eks_host" {
  value = data.aws_eks_cluster.eks-cluster.endpoint
}

output "cluster_ca_certificate" {
  value = data.aws_eks_cluster.eks-cluster.certificate_authority[0].data
}
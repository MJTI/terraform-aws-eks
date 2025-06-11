resource "aws_iam_role" "eks-node" {
  name = "${var.env}-${var.project}-eks-node"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name       = "eks-node"
    Managed_By = "Terraform"
    Project    = var.project
  }
}

resource "aws_iam_role_policy_attachment" "amazon-eks-worker-node-policy" {
  role       = aws_iam_role.eks-node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "amazon-ec2-container-registry-pull-only" {
  role       = aws_iam_role.eks-node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

resource "aws_iam_role_policy_attachment" "amazon-eks-cni-policy" {
  role       = aws_iam_role.eks-node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
resource "aws_iam_role" "eks-cluster" {
  name = "${var.env}-${var.project}-eks-cluster"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name       = "eks-cluster"
    Managed_By = "Terraform"
    Project    = var.project
  }
}

resource "aws_iam_role_policy_attachment" "amazon-eks-cluster-policy" {
  role       = aws_iam_role.eks-cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
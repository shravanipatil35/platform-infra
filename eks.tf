resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-${var.environment}-eks"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = aws_subnet.private[*].id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-eks"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-${var.environment}-nodes"
  node_role_arn   = aws_iam_role.eks_nodes.arn

  subnet_ids = aws_subnet.private[*].id

  instance_types = ["t3.micro"]

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-node"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_read_only
  ]
}
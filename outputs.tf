output "aws_region" {
  value = var.aws_region
}

output "project_name" {
  value = var.project_name
}

output "environment" {
  value = var.environment
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}
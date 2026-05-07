output "instance_public_ip" {
  description = "Public IP of the server: SSH here"
  value       = aws_instance.minecraft-server.public_ip
}

output "ecr_repository_url" {
  description = "ECR repository URL: use this in the GitHub Actions workflow"
  value       = aws_ecr_repository.minecraft-server.repository_url
}
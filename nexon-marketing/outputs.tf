output "url" {
  description = "URL of the ECR"
  value       = module.ecr-repository.url
}

output "repo_name" {
  description = "Name of the ECR Repo"
  value       = module.ecr-repository.repo_name
}

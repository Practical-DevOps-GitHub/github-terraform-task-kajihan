output "repository_url" {
  description = "URL of the GitHub repository"
  value       = "https://github.com/${var.github_owner}/${var.repository_name}"
}

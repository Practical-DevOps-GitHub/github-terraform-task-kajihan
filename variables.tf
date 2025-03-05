variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

variable "github_owner" {
  description = "GitHub owner"
  type        = string
}

variable "repository_name" {
  description = "Name of the GitHub repository"
  type        = string
}

variable "deploy_key" {
  description = "Public SSH key for deploy key"
  type        = string
  sensitive   = true
}

variable "pat_value" {
  description = "Personal Access Token value for GitHub Actions"
  type        = string
  sensitive   = true
}

variable "discord_webhook" {
  description = "Discord webhook URL for notifications"
  type        = string
  sensitive   = true
}

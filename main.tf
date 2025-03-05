provider "github" {
  token = var.github_token
  owner = var.github_owner
}

module "github_setup" {
  source          = "./modules/github"
  repository_name = var.repository_name
  github_owner    = var.github_owner
  deploy_key      = var.deploy_key
  pat_value       = var.pat_value
  discord_webhook = var.discord_webhook
}
# Adding the softservedata user as a collaborator
resource "github_repository_collaborator" "collaborator" {
  repository = var.repository_name
  username   = "softservedata"
  permission = "push"
}

# Create a develop branch and set it as the default branch
resource "github_branch" "develop" {
  repository = var.repository_name
  branch     = "develop"
}

resource "github_branch_default" "default" {
  repository = var.repository_name
  branch     = github_branch.develop.branch
}

# Protecting main and develop branches
resource "github_branch_protection" "main_protection" {
  repository_id = var.repository_name
  pattern       = "main"
  required_pull_request_reviews {
    required_approving_review_count = 1
    require_code_owner_reviews      = true
  }
  allows_deletions    = false
  allows_force_pushes = false
}

resource "github_branch_protection" "develop_protection" {
  repository_id = var.repository_name
  pattern       = "develop"
  required_pull_request_reviews {
    required_approving_review_count = 2
  }
  allows_deletions    = false
  allows_force_pushes = false
}

# Assign softservedata as code owner for all files in main
resource "github_repository_file" "codeowners" {
  repository          = var.repository_name
  branch              = "main"
  file                = "CODEOWNERS"
  content             = "* @softservedata"
  commit_message      = "Add CODEOWNERS file"
  overwrite_on_create = true
}

# Adding pull request template
resource "github_repository_file" "pr_template" {
  repository          = var.repository_name
  branch              = "main"
  file                = ".github/pull_request_template.md"
  content             = <<EOF
## Describe your changes

## Issue ticket number and link

## Checklist before requesting a review
- [ ] I have performed a self-review of my code
- [ ] If it is a core feature, I have added thorough tests
- [ ] Do we need to implement analytics?
- [ ] Will this be part of a product update? If yes, please write one phrase about this update

EOF
  commit_message      = "Add pull request template"
  overwrite_on_create = true
}

# Adding DEPLOY_KEY
resource "github_repository_deploy_key" "deploy_key" {
  repository = var.repository_name
  title      = "DEPLOY_KEY"
  key        = var.deploy_key
  read_only  = false
}

# Setting up Discord notifications via webhook
resource "github_repository_webhook" "discord_webhook" {
  repository = var.repository_name
  events     = ["pull_request"]
  configuration {
    url          = var.discord_webhook
    content_type = "json"
    insecure_ssl = false
  }
  active = true
}

# Adding PAT to secrets for GitHub Actions
resource "github_actions_secret" "pat_secret" {
  repository      = var.repository_name
  secret_name     = "PAT"
  plaintext_value = var.pat_value
}

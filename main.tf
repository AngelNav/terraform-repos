/*
- What organizations will we use
- what credetials do we need
- are we able to delete or archive repos?
- What constitutes done?
    - repositories
    - teams
    - teams in repositories
    - repo contents?
    - github actions?
*/

/* provider "github" {
  token = var.github_token
}

resource "github_repository" "repository" {
  for_each = var.repos

  name        = each.value.name
  description = each.value.description
  visibility  = each.value.visibility
} */


terraform {
  required_version = ">= 0.13"
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}


module "repository" {
  source       = "./modules/repository"
  github_token = var.github_token
  repos_file   = var.repos_file
}
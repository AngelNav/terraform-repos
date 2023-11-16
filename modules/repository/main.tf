provider "github" {
  token = var.github_token
}

locals {
  #get json
  repo_data_map = { 
    for repo in jsondecode(file(var.repos_file)).repositories : 
    repo.name => repo 
  }
}


resource "github_repository" "repository" {
  for_each = local.repo_data_map

  name        = each.value.name
  description = each.value.description
  visibility  = each.value.visibility
}
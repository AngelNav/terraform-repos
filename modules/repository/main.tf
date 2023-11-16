provider "github" {
  token = var.github_token
}

resource "github_repository" "repository" {
  for_each = jsondecode(file(var.repos_file))

  name        = each.value.name
  description = each.value.description
  visibility  = each.value.visibility
}
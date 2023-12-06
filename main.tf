data "github_organization" "mgm" {
  name = var.organization
}

# Create infrastructure repository
resource "github_repository" "repositories" {
  for_each = { for repo in local.repositories : repo.name => repo }

  archive_on_destroy = true
  archived           = each.value.archived

  name        = each.value.name
  description = each.value.description
  visibility  = "internal"
}

# Assign teams to repositories
resource "github_team_repository" "repos_team" {
  for_each = {
    for repo in local.repositories :
    repo.name => csvdecode(fileexists("${local.repo_teams_path}/${repo.name}.csv") ?
    file("${local.repo_teams_path}/${repo.name}.csv") : "")
    if fileexists("${local.repo_teams_path}/${repo.name}.csv")
  }

  team_id    = github_team.all[each.value[0]["team_name"]].id
  repository = github_repository.repositories[each.key].id
  permission = each.value[0]["permission"]
}
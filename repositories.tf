# Create infrastructure repository
resource "github_repository" "repositories" {
  for_each = { for repo in local.repositories : repo.name => repo }

  name        = each.value.name
  description = each.value.description
  visibility  = each.value.visibility

  /* Plans that destroy repository releases will delete the repository on
    GitHub and that shouldn't be done in the normal course of operation. */
  prevent_destroy = true
  /* Ignore fields that are not set or managed by this terraform project
  to prevent unecessary drift. */
  ignore_changes = [
    allow_merge_commit,
    description,
    etag,
    has_downloads,
    has_issues,
    has_projects,
    has_wiki,
    homepage_url,
    vulnerability_alerts
  ]
}


# Add memberships for repositories
resource "github_team_repository" "repos_team" {

}


# Create infrastructure repository
/* resource "github_repository" "infrastructure" {
  name = "learn-tf-infrastructure"
}

# Add memberships for infrastructure repository
resource "github_team_repository" "infrastructure" {
  for_each = {
    for team in local.repo_teams_files["infrastructure"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.infrastructure.id
  permission = each.value.permission
}

# Create application repository
resource "github_repository" "application" {
  name = "learn-tf-application"
}

# Add memberships for application repository
resource "github_team_repository" "application" {
  for_each = {
    for team in local.repo_teams_files["application"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.application.id
  permission = each.value.permission
} */
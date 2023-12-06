resource "github_team" "all" {
  for_each = {
    for team in csvdecode(file("files/teams.csv")) :
    team.name => team
  }

  name                      = each.value.name
  description               = each.value.description
  privacy                   = each.value.privacy
  create_default_maintainer = true
}

resource "github_team_members" "members" {
  team_id = github_team.all[each.key].id

  for_each = {
    for team, members in local.team_members_files : team => members
  }

  dynamic "members" {
    for_each = each.value

    content {
      username = members.value.username
      role     = members.value.role
    }
  }
}
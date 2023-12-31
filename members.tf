data "github_membership" "all" {
  for_each = {
    for member in csvdecode(file("files/members.csv")) :
    member.username => member
  }

  username = each.value.username
}
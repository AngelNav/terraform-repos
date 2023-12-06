/* output "terraform_repositories" {
    value = [for repo in local.repositories : repo.name]
} */

output "unmanaged_repositories" {
  value = setsubtract(
    [for repo in data.github_organization.mgm.repositories : trimprefix(repo, "${var.organization}/")],
    setunion([for repo in local.repositories : repo.name], ["${var.organization}"])
  )
}

/* output "unmanaged_members" {
  value = setsubtract(
    [for member in data.github_organization.mgm.users : lower(member.login)],
    [for member in local.members : lower(member.username)]
  )
} */
variable "github_token" {
  type        = string
  description = "GitHub personal access token"
}

variable "repos_file" {
  type        = string
  description = "The path to the JSON file containing the list of repositories to create"
}

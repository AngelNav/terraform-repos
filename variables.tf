variable "github_token" {
  type        = string
  default     = "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"
  description = "GitHub personal access token"
}

variable "repos_file" {
  type        = string
  default     = "repositories.json"
  description = "The path to the JSON file containing the list of repositories to create"
}

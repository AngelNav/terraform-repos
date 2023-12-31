# Using terraform for project administrators

## Setting up the terraform project

### GitHub API Token

You will need a GitHub API token in your environment that has at least admin:org permissions for the MGMResorts organization.
This token should be in an exported environment variable `GITHUB_TOKEN`.
It is recommended that you use short lived tokens which are exported only for the shell which you are using to run terraform. 
regenerated each time that you need them rather than keeping an exported token in your environment

### Terraform

Terraform is available from <https://terraform.io>.
If you are running on Arch Linux terraform is packaged in the Arch repositories and stays up to date.
If you're running on Ubuntu, Debian, or Fedora you can add the Hashicorp repository to [download terraform](https://www.terraform.io/downloads).

Once changes to this repository are merged, terraform changes must be planned and applied before taking effect.
This terraform project is not currently set up to run automatically in order to require a human in the loop for safety.
It would be very bad if a misfired terraform run deleted all release repositories.

## Initializing a local terraform workspace

Run `terraform init` in the local repository to initialize local terraform state and fetch any required providers.
If you're developing the terraform project and need to upgrade any providers be sure to run `terraform init -upgrade` to allow the upgraded providers to be installed. By default terraform locks provider versions to prevent unintended drift.

## Reviewing terraform changes

In a configured workspace run `terraform plan -out plan.out > plan.txt`.
The output, piped to `plan.txt` can be viewed with `less -R plan.txt`
This will display a list of changes terraform will make for you to review. 
The `plan.out` file is used to automatically apply the plan exactly as it was previously reviewed, the plan will fail to apply if it becomes stale because state changed between plan and application thus preventing unintended changes between reviewing and applying a plan.

Terraform organizes managed objects into resources which can be added, changed, and destroyed.
This project uses the GitHub provider to manage a GitHub organization with terraform.

In most situations for this project you should only see changed and added resources.

`github_repository` resources _must not_ be destroyed or the corresponding repository will be deleted on GitHub.
`github_membership` resources will be created for each individual member of the MGMResorts organization or destroyed when a member is removed from all teams in the organization.
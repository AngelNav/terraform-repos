#!/bin/bash

###############################################################################
# Script: unmanaged_repositories.sh
# Description: This script generates a CSV file containing a list of GitHub
#              repositories. It is developed to address the requirements of a
#              DevOps Manager seeking to facilitate the transition to a new
#              organizational structure on GitHub.
# Ticket: #DOPS-535
# Usage: ./scripts/unmanaged_repositories.sh
###############################################################################

# Create the CSV file
echo "name,description,archived" > ./files/unmanaged_repositories.csv

# Get the JSON output from Terraform
repositories_json=$(terraform output -json unmanaged_repositories)

# Iterate over the Terraform output and write to the CSV file
for repo in $(echo "$repositories_json" | jq -r '.[]'); do
  echo "$repo" | awk -v OFS=, '{print $1, $2, $3 ? "true" : "false"}' >> ./files/unmanaged_repositories.csv
done

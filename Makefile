default: help

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: setup
init: # Initialize working directory
	terraform init

.PHONY: plan
plan: # Describe changes to be made to the infrastructure.
	terraform plan

.PHONY: validate
validate: # Verify the syntax of .tf files
	terraform validate

.PHONY: apply show
apply: # Implement changes described in the plan
	terraform apply -auto-approve

.PHONY: destroy
destroy: # Delete all resources created
	terraform destroy -auto-approve

.PHONY: show
show: # Show the current state of the infrastructure
	terraform destroy -auto-approve
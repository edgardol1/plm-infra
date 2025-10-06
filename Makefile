.PHONY: plan plan-json fmt check all
plan:
	./scripts/terraform_plan.sh
plan-json:
	./scripts/terraform_plan_json.sh
fmt:
	terraform -chdir=terraform fmt -recursive
check:
	./scripts/_require_tf.sh && terraform -chdir=terraform fmt -check -recursive
all: check plan

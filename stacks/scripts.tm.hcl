script "terraform" "deploy" {
  description = "Deploy a Terraform stack"
  job {
    commands = [
      ["terraform", "init", "-migrate-state"],
      ["terraform", "validate"],
      ["terraform", "apply", "-auto-approve"]
    ]
  }
}

generate_hcl "_generated_locals.tf" {
  content {
    locals {
      resource_suffix = terramate.stack.name
    }
  }
}

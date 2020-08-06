include {
  path = find_in_parent_folders()
}

terraform {
  extra_arguments "mediawiki_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy"
    ]
    required_var_files = [
      "${get_parent_terragrunt_dir()}/variables/compute/mediawiki-instance/development.tfvars"
    ]
  }
}


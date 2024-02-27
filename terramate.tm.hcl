terramate {
  required_version                   = "~> 0.4.6"
  required_version_allow_prereleases = false

  config {
    git {
      default_remote = "origin"
      default_branch = "main"
    }

    run {
      env {
        TF_PLUGIN_CACHE_DIR = "${terramate.root.path.fs.absolute}/.terraform-cache-dir"
      }
    }
  }
}

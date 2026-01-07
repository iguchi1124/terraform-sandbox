terraform {
  required_version = ">= 1.5.0"
}

locals {
  project_name = "demo-stack"

  global_tags = {
    project = local.project_name
    owner   = "platform"
  }

  environments = {
    dev = {
      tags = merge(local.global_tags, {
        environment = "dev"
        workspace   = "github-actions"
      })
      features = [
        "module-free",
        "static-output"
      ]
    }
  }
}

output "environment_summaries" {
  description = "Metadata for each environment consumed by GitHub Actions tests."
  value = {
    for env_name, config in local.environments :
    env_name => {
      project  = local.project_name
      tags     = config.tags
      features = config.features
    }
  }
}

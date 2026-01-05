terraform {
  required_version = ">= 1.5.0"
}

locals {
  project     = "sample-stack"
  environment = "development"

  tags = {
    project     = local.project
    environment = local.environment
    workspace   = "github-actions"
  }

  mock_capabilities = [
    "plan-only",
    "no-providers",
    "safe-to-run"
  ]
}

output "development_summary" {
  description = "Summary output consumed by CI tests."
  value = {
    project      = local.project
    environment  = local.environment
    tags         = local.tags
    capabilities = local.mock_capabilities
  }
}

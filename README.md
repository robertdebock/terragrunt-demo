# Terragrunt demo

This repository contains a simpel sample of what Terragrunt can do.

```
.
├── modules             # This contains (almost) normal Terraform code.
│   ├── main.tf
│   ├── providers.tf
│   └── versions.tf
├── development         # This contains the specific settings for development.
│   └── terragrunt.hcl
├── production         # This contains the specific settings for production.
│   └── terragrunt.hcl
└── README.md
```

## Requirements

1. Terraform installed.
2. Terragrunt installed.
3. Environment variable `DIGITALOCEAN_TOKEN` set.

## Running terragrunt

1. Go into the directory that you want to deploy, for example `development`.
2. Run `terragrunt plan` to understand what is going to happen.
3. Run `terragrunt apply` to actually change the infrastructure.
4. Run `terraform destroy` to save money.

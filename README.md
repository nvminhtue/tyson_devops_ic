# Introduction
This project's main function is to generate the infrastructure for the [example application](https://github.com/nvminhtue/tyson_devops_ic_app)

The Terraform cloud workspace can be found [here](https://app.terraform.io/app/nvminhtue/workspaces)

# Project setup
- Terraform v1.6.1
- [asdf](https://github.com/asdf-vm/asdf)

## Local development
- Install the terraform plugin
```bash
asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp
```
- Install the terraform based on the project version
```bash
asdf install
```

- Use the plugin
```bash
asdf local terraform 1.6.1
```

# Documentation
- [Wiki](https://github.com/nvminhtue/tyson_devops_ic/wiki)
- [Trivy](https://github.com/aquasecurity/trivy)
- [Terraform Cloud](https://app.terraform.io/app/nvminhtue/workspaces)

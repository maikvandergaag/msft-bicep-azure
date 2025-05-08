# Azure Bicep Infrastructure as Code Repository

This repository provides a modular Infrastructure as Code (IaC) solution for deploying Azure resources using Bicep. It includes reusable Bicep modules for common Azure services such as resource groups, storage accounts, managed identities, Application Insights, and Log Analytics.

## Features

- **Modular Bicep Templates:** Easily compose and reuse modules for various Azure services.
- **Parameterized Deployments:** Flexible deployment files for different environments.
- **Automated Testing:** Bicep assertions and validation scripts to ensure template quality.
- **CI/CD Integration:** GitHub Actions workflows for building, testing, and deploying infrastructure.
- **Azure Best Practices:** Templates and workflows follow Azure recommended best practices for security, scalability, and maintainability.

## Getting Started

1. Clone this repository.
2. Review and customize the Bicep modules and parameter files as needed.
3. Use the provided GitHub Actions workflows or Azure CLI to deploy your infrastructure.

## Example Deployment Command

```sh
az deployment sub create \
  --location <location> \
  --template-file main.bicep \
  --parameters @parameters/dev.json
```

## Resources

- [Bicep Documentation](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [Azure CLI Documentation](https://learn.microsoft.com/cli/azure/)
- [GitHub Actions for Azure](https://github.com/Azure/actions)

---
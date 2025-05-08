metadata info = {
  title: 'Managed Identity Module'
  version: '1.0.0'
  author: '3fifty'
}

metadata description = '''
Module for a managed identities
'''

@description('Specifies the name for the managed identity.')
param name string

@description('the location for the managed identity')
param location string = resourceGroup().location

@description('''
Array of objects that specify the federation between a repository and the managed identity. The array needs to have the following structure:

```
[
  {
    githubRepo: "[Repo Name]",
    githubOrganization: "[GitHub organization]",
    githubEnvironment: "[GitHub Environment]"
  }
]

''')
param gitHubFederation array = []


resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-01-31-preview' = {
  name: name
  location: location
}

resource federatedCredentials 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2025-01-31-preview'  =[for item in gitHubFederation: {
  name: 'github-env-${item.githubEnvironment}'
  parent: identity
  properties: {
    audiences: [
      'api://AzureADTokenExchange'
    ]
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:${item.githubOrganization}/${item.githubRepo}:environment:${item.githubEnvironment}'
  }
}]

output idClientId string = identity.properties.clientId
output idPrincipalId string = identity.properties.principalId
output idName string = identity.name

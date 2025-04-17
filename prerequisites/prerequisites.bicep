targetScope = 'subscription'

import * as res from '../functions/naming.bicep'

metadata info = {
  title: 'Prerequisites file for demos'
  author: 'Maik van der Gaag'
}

metadata description = '''
Deployment file that deploy's resources for the prerequisites of the demo
'''

@description('The descrfiptive name that will be used in the nameing of the resources')
param name string

@description('The location for the resources in the deployment')
param location string = deployment().location

@allowed([
  'tst'
  'acc'
  'prd'
  'dev'
])
@description('The environment were the service is beign deployed to (tst, acc, prd, dev)')
param env string

var managedIdentityName = res.getName(name, env, '').managedIdentity
var bicepgroup = res.getName(name, env, 'sponsor').resourceGroup

module bicepGroup '../module/resourcegroup.bicep' = {
  name: 'deploy-bicepGroup'
  params: {
    name: bicepgroup
    location: location
    tags: {
      clean: false
    }
  }
}

module identity '../module/managedidentity.bicep' = {
  name: 'deploy-managedIdentity'
  params: {
    name: managedIdentityName
    location: location
    gitHubFederation: [
      {
        githubRepo: 'msft-bicep-azure'
        githubOrganization: 'maikvandergaag'
        githubEnvironment: 'demo'
      }
    ]
  }
  dependsOn: [bicepGroup]
  scope: resourceGroup(bicepgroup)
}

module rbac '../module/rgrbac.bicep' = {
  name: 'deploy-rbac'
  params: {
    identity: identity.outputs.idPrincipalId
    roleDefinitionId: '8e3af657-a8ff-443c-a75c-2fe8c4bcb635'
  }
  scope: resourceGroup(bicepgroup)
}

output clientId string = identity.outputs.idClientId
output tenantId string = subscription().tenantId
output subscriptionId string = subscription().subscriptionId

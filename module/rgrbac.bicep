targetScope = 'subscription'

metadata info = {
  title: 'Resource Group RBAC assignment'
  description: 'Module for doing a RBAC assignment on a resource group'
  version: '1.0.0'
  author: 'maikvandergaag'
}

metadata description = '''
Module for adding a RBAC assignment to a resource group
'''

@description('The identity to assign the role to')
param identity string

@description('The role definition id to assign to the identity')
param roleDefinitionId string

resource roleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: roleDefinitionId
}

resource rbac 'Microsoft.Authorization/roleAssignments@2022-04-01' =  {
  name:  guid(identity, roleDefinitionId, subscription().subscriptionId)
  properties:{
    roleDefinitionId: roleDefinition.id
    principalId: identity
  }
}

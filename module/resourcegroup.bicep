targetScope = 'subscription'

metadata info = {
  title: 'Resource group Module'
  description: 'Module for creating a resource group'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}
@description('The name of the storageaccount will be in the format st[name][environment]')
param name string

@description('The location of the resource group')
param location string = deployment().location

@description('The tags of the resource group')
param tags object = {}

var defaultTags = {
  deployedby : deployer().objectId
}

var tagsToApply = union(defaultTags, tags)

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: name
  location: location
  tags: tagsToApply
}

output rgName string = rg.name
output rgId string = rg.id
output objectItem object = rg

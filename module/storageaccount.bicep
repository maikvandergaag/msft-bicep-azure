metadata info = {
  title: 'Storage Account Module'
  description: 'Module for creating a storage account'
  version: '1.0.0'
  author: 'Maik van der Gaag'
}

@description('The name of the storageaccount will be in the format st[name][environment]')
param name string

@description('The location of the storageaccount')
param location string = resourceGroup().location

@description('The SKU of the storage account')
param storageSKU string = 'Standard_LRS'

resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: name
  location: location
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}


output name string = storage.name
output id string = storage.id

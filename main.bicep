targetScope = 'subscription'

import * as res from 'functions/naming.bicep'

metadata info = {
  title: 'Main file for demo 04'
  author: 'Maik van der Gaag'
}

metadata description = '''
Deployment file that deploy's resources to a management group
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

var monitoringGroupName = res.getName('bicep-azure-mon', env, 'sponsor').resourceGroup
var applicationGroupName = res.getName('bicep-azure-app', env, 'sponsor').resourceGroup
var logAnalyticsName = res.getName(name, env, '').logAnalytics
var appInsightsName = res.getName(name, env, '').applicationInsights


module monitoringGroup 'module/resourcegroup.bicep' ={
  name: 'deploy-monitoringGroup'
  params:{
    name: monitoringGroupName
    location: location
  }
}

module applicationGroup 'module/resourcegroup.bicep' ={
  name: 'deploy-applicationGroup'
  params:{
    name: applicationGroupName
    location: location
  }
}

module appInsights 'module/applicationinsights.bicep' = {
  name: 'deploy-appInsights'
  params: {
    logAnalyticsWorkspaceId: loganalytics.outputs.workspaceId
    name: appInsightsName
    location: location
  }
  dependsOn: [monitoringGroup]
  scope: resourceGroup(monitoringGroupName)
}

module loganalytics 'module/loganalytics.bicep' = {
  name: 'deploy-loganalytics'
  params: {
    name: logAnalyticsName
    location: location
  }
  dependsOn: [monitoringGroup]
  scope: resourceGroup(monitoringGroupName)
}

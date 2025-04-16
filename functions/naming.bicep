@export()
type nameObject = {
  storageAccount: string
  logAnalytics: string
  applicationInsights: string
  resourceGroup: string
}

var storageabbreviation = 'st'
var applicationinsightsabbreviation = 'appi'
var loganalyticsabbreviation = 'log'
var resourcegroupabbreviation = 'rg'

@export()
func getName(name string, env string, prefix string) nameObject =>
  {
    storageAccount: '${storageabbreviation}${take(replace(name, '-',''), 18)}${env}'
    logAnalytics: '${loganalyticsabbreviation}-${name}-${env}'
    applicationInsights: '${applicationinsightsabbreviation}-${name}-${env}'
    resourceGroup: prefix == '' ? '${resourcegroupabbreviation}-${name}-${env}' : '${prefix}-${resourcegroupabbreviation}-${name}-${env}'
  }

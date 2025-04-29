import * as res from '../functions/naming.bicep'

@description('The descrfiptive name that will be used in the nameing of the resources')
param name string


@allowed([
  'tst'
  'acc'
  'prd'
  'dev'
])
@description('The environment were the service is beign deployed to (tst, acc, prd, dev)')
param env string

param expectedName string

var storageName = res.getName(name, env, '').storageAccount

assert nameHyphen = !contains(storageName, '-')
assert containsEnv = contains(storageName, env)
assert isName = expectedName == storageName

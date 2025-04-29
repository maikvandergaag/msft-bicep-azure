test namingTest 'test.bicep' = {
  params: {
    name: 'test1'
    env: 'prd'
    expectedName: 'sttest1prd'
  }
}


test failnamingTest 'test.bicep' = {
  params: {
    name: 'test1'
    env: 'prd'
    expectedName: 'sttest1-prd'
  }
}

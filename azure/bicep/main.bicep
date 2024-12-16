param name string = 'gooner1129'
param location string = 'japaneast'

var strageSku = 'Standard_LRS'

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: name
  location: location
  kind: 'Storage'
  sku:{
    name: strageSku
  }
}

output storageId string = stg.id

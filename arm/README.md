# Azure Resource Manager Template

## Prepare
```shell-session
$ az account set -s <Subscription ID>
$ az account show
```

## Deploy
```shell-session
$ az group create -n <ResourceGroup Name> -l japaneast
$ az group deployment create -g <ResourceGroup Name> --template-file template.json --parameters parameters.json
```

## Validate
```shell-session
$ az group deployment validate -g <ResourceGroup Name> --template-file template.json --parameters parameters.json
```

## Cleanup
```shell-session
$ az group delete -n <ResourceGroup Name>
```

## Refelence

### Define resources in Azure Resource Manager templates
https://docs.microsoft.com/en-us/azure/templates/

### Azure REST API Reference
https://docs.microsoft.com/en-us/rest/api/azure/

https://docs.microsoft.com/en-us/rest/api/monitor/metricalerts/get

https://docs.microsoft.com/en-us/rest/api/monitor/scheduledqueryrules/get

### Azure Resource Explorer
https://resources.azure.com/

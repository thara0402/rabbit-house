# Project Bicep

## Prepare
```shell-session
$ az account set -s <Subscription ID>
$ az account show
```

## Build
```shell-session
$ bicep build main.bicep
```

## Deploy
```shell-session
$ az group create -n <ResourceGroup Name> -l japaneast
$ az deployment group create -f ./main.json -g <ResourceGroup Name>
```

## Deploy with parameters
```shell-session
$ az group create -n <ResourceGroup Name> -l japaneast
$ az deployment group create -f ./main.json -g <ResourceGroup Name> --parameters location=japaneast name=gooner1129
```

## Cleanup
```shell-session
$ az group delete -n <ResourceGroup Name>
```

## Refelence

### Project Bicep - an ARM DSL
https://github.com/Azure/bicep

### Bicep Playground
https://bicepdemo.z22.web.core.windows.net/

### Bicep 紹介
https://www.slideshare.net/takekazuomi/jazugn29bicep

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

## Sample
### Virtual Machines
- [シンプルな Windows 仮想マシンを作成する](./vm-simple-windows/template.json)
- [カスタムイメージから仮想マシンを作成する](./vm-custom-image/template.json)
- [Shared Image Gallery から仮想マシンを作成する](./vm-sig/template.json)
- [複数の仮想マシンを作成する](./vm-copy/template.json)
- [カスタムイメージから複数の仮想マシンを作成する](./vm-copy-custom-image/template.json)
- [Shared Image Gallery から複数の仮想マシンを作成する](./vm-copy-sig/template.json)

### Web Apps
- [Application Gateway v2 + Web Apps + SQL Database を作成する](./web-db-app/template.json)

### Alerts
- [仮想マシンにアラートを設定する](./alert/template.json)
- [Web Apps にアラートを設定する](./alert-web/template.json)
- [SQL Database にアラートを設定する](./alert-sql/template.json)


## Refelence

### Define resources in Azure Resource Manager templates
https://docs.microsoft.com/en-us/azure/templates/

### Azure REST API Reference
https://docs.microsoft.com/en-us/rest/api/azure/

https://docs.microsoft.com/en-us/rest/api/monitor/metricalerts/get

https://docs.microsoft.com/en-us/rest/api/monitor/scheduledqueryrules/get

### Azure Resource Explorer
https://resources.azure.com/

## Recommend Extensions for Visual Studio Code
### Bracket Pair Colorizer
https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer

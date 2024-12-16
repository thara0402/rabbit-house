# Private Link


## Web Apps の作成
SKU
P1v2 以上

## VNet の作成
10.1.0.0/16
webapps-subnet
10.1.0.0/24
sql-subnet
10.1.2.0/24

## Web Apps の VNet Integration 有効化
webapps-subnetを指定

## SQL Database の作成
Private endpoint の追加
sql-subnetを指定

## SQL Database の Public network access 拒否を有効化
server の firewalls and virtual networks

## Web Apps の AppSettings
WEBSITE_VNET_ROUTE_ALL  1
WEBSITE_DNS_SERVER      168.63.129.16

Save のあと、ReStart

## SQL Database の Private endpoint を確認
gooner0604.database.windows.net   10.1.2.4

## Web Apps → SQL Database の疎通確認
Consoleメニューから実行
sqlcmd -S 10.1.2.4 -U thara@gooner0604 -P P@ssW0rd

SQL Database の Metrics
master への Successful Connection

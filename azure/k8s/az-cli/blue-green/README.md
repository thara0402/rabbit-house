# AKS クラスターの Blue / Green デプロイ
## Azure Application Gateway の構築
AKS のフロントに配置する Application Gateway のネットワーク構成を設計し、[create-appgw.sh](./create-aks.sh) の変数値を編集してから実行します。
```shell-session
$ ./create-appgw.sh
```

## 旧バージョンの AKS の構成変更
Public IP Address を利用してサービスを公開せず、Internal IP Address だけを公開するように変更します。  
service.yaml の annotations を追加した Service に作り変えます。
```yaml
  annotations:
    service.beta.kubernetes.io/azure-load-balancer-internal: "true"
```
Application Gateway と AKS の仮想ネットワークをピアリングし、バックエンドプールに AKS の Internal IP Address を設定します。
この構成により、Application Gateway の Public IP Address でサービスに接続できるようになります。

## 新バージョンの AKS の環境構築
### AKS の環境構築
構築するリソース群の名前とネットワーク構成を設計し、[create-aks.sh](./create-aks.sh)の変数値を編集してから、２つのパラメータを指定して実行します。
| パラメータ | パラメータ値 |
----|---- 
| 1 | サービスプリンシパルの appId |
| 2 | サービスプリンシパルの secret(password) |

```shell-session
$ ./create-aks.sh <appId> <secret>
```

構築するリソース群の名前とネットワーク構成が、構築済みの AKS と重複しないように注意してください。

namespace ごとに必要な AKS のリソースを作成するため、[create-customer-aks.sh](./create-customer-aks.sh)のパラメータを編集してから、２つのパラメータを指定して実行します。
| パラメータ | パラメータ値 |
----|---- 
| 1 | Azure Container Registry の username |
| 2 | Azure Container Registry の password |

```shell-session
$ ./create-customer-aks.sh <username> <password>
```

最後に、AKS に必要なサービス群をデプロイします。

## AKS の切り替え
Application Gateway のバックエンドプールにおいて、AKS の Internal IP Address を旧バージョンから新バージョンに切り替えることができます。



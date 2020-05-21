# Create Azure Kubernetes Services with Azure CLI

## AKS の環境構築
構築するリソース群の名前とネットワーク構成を設計し、[create-aks.sh](./create-aks.sh) の変数値を編集してから、２つのパラメータを指定して実行します。
| パラメータ | パラメータ値 |
----|---- 
| 1 | サービスプリンシパルの appId |
| 2 | サービスプリンシパルの secret(password) |

```shell-session
$ ./create-aks.sh <appId> <secret>
```

namespace ごとに必要な AKS のリソースを作成するため、[create-customer-aks.sh](./create-customer-aks.sh)のパラメータを編集してから、２つのパラメータを指定して実行します。
| パラメータ | パラメータ値 |
----|---- 
| 1 | Azure Container Registry の username |
| 2 | Azure Container Registry の password |

```shell-session
$ ./create-customer-aks.sh <username> <password>
```

## AKS クラスターの Blue / Green デプロイ
AKS クラスターの Blue / Green デプロイは、[こちら](./blue-green/README.md) を参照。
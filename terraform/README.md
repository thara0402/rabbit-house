# How to use Terraform for Azure Kubernetes Service

## Install

### For Windows
公式サイトからダウンロードして、環境変数のパスを通す
https://www.terraform.io/downloads.html


```shell-session
$ az account show --query "{subscriptionId:id, tenantId:tenantId}"
$ az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"
```

```shell-session
$ set-env.cmd
```

```shell-session
$ terraform init
$ terraform plan
$ terraform apply


$ terraform destroy
```


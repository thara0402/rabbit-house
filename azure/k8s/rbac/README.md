# How to use RBAC

## Prepare

Kubernetes scripts  
https://github.com/zlabjp/kubernetes-scripts

## Create Service Account for only View

RBACを有効にして、AKSを作成する

資格情報の取得

```shell-session
# cluster admin
$ az aks get-credentials --resource-group gooner0227 --name gooner0227 --admin
# cluster user
$ az aks get-credentials --resource-group gooner0227 --name gooner0227
```

ダッシュボードの権限付与

```shell-session
$ kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard
```

Service Accountの作成

```shell-session
$ kubectl create sa test01
```

読み取り専用のClusterRole（View）に、Service Account（test01）をひもづける

```shell-session
$ kubectl create rolebinding test01-view --clusterrole=view --serviceaccount=default:test01 --namespace=default
```

上記で作成したService Accountのkubeconfigを作成

```shell-session
$ create-kubeconfig test01 > config-test01
```

権限確認
```shell-session
$ grep client-certificate-data clouddrive/config-rabc | awk '{print $2}' | base64 -d | openssl x509 -text
Subject: O=system:masters, CN=masterclient
```

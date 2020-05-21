#!/bin/bash

if [ $# -ne 2 ]; then
  echo "実行するには2個の引数が必要です。" 1>&2
  exit 1
fi

# ACR 接続情報
DOCKER_SERVER=xxx.azurecr.io
DOCKER_USERNAME=$1
DOCKER_PASSWORD=$2

# リソース名の定義
PREFIX=gooner
NAMESPACE=customer001
RESOURCE_GROUP=${NAMESPACE}
STORAGE_ACCOUNT_NAME=${PREFIX}${NAMESPACE}
SECRET_NAME=azure-secret

# k8s 名前空間の作成
kubectl create namespace ${NAMESPACE}

# ACR に接続する Kubernetes secret の作成
kubectl create secret docker-registry gooner-service-secret \
--docker-server=${DOCKER_SERVER} \
--docker-username=${DOCKER_USERNAME} \
--docker-password=${DOCKER_PASSWORD} \
--docker-email=example@sony.com \
--namespace ${NAMESPACE}

# Azure Storage に接続する Kubernetes secret の作成
STORAGE_KEY=$(az storage account keys list -g $RESOURCE_GROUP -n $STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv)
kubectl create secret generic ${SECRET_NAME} \
--from-literal=azurestorageaccountname=$STORAGE_ACCOUNT_NAME \
--from-literal=azurestorageaccountkey=$STORAGE_KEY \
--namespace ${NAMESPACE}


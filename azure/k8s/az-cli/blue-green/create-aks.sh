#!/bin/bash

if [ $# -ne 2 ]; then
  echo "実行するには2個の引数が必要です。" 1>&2
  exit 1
fi

# サービスプリンシパル
SERVICE_PRINCIPAL=$1
CLIENT_SECRET=$2

# リソース名の定義
PREFIX=gooner02
LOCATION=eastus
KUBERNETES_VERSION=1.15.10
RESOURCE_GROUP=${PREFIX}
VNET_NAME=${PREFIX}-vnet
LOG_ANALYTICS_NAME=${PREFIX}-la
AKS_NAME=${PREFIX}-aks

# AKS のネットワーク設計
# https://docs.microsoft.com/ja-jp/azure/aks/configure-azure-cni?view=azure-cli-latest#deployment-parameters
VNET_ADDRESS_PREFIX=10.3.0.0/16
SUBNET_PREFIX=10.3.0.0/24
DOCKER_BRIDGE_ADDRESS=172.17.0.1/16
DNS_SERVICE_IP=10.4.0.10
SERVICE_CIDR=10.4.0.0/24

# AKS のサイジング設計
NODE_COUNT=3
NODE_SIZE=Standard_D4_v3

# リソースグループの作成
az group create -n ${RESOURCE_GROUP} -l ${LOCATION}

# 仮想ネットワークの作成
az network vnet create -g ${RESOURCE_GROUP} -n ${VNET_NAME} \
--address-prefix ${VNET_ADDRESS_PREFIX} \
--subnet-name aks-subnet \
--subnet-prefix ${SUBNET_PREFIX}

# サービスプリンシパルに権限付与
SUBNET_ID=$(az network vnet subnet list -g ${RESOURCE_GROUP} --vnet-name ${VNET_NAME} --query "[0].id" --output tsv)
az role assignment create --assignee ${SERVICE_PRINCIPAL} --scope ${SUBNET_ID} --role "network contributor"

# ログアナリティクスの作成
az monitor log-analytics workspace create -g ${RESOURCE_GROUP} -n ${LOG_ANALYTICS_NAME}
WORKSPACE_RESOURCE_ID=$(az monitor log-analytics workspace show -g ${RESOURCE_GROUP} -n ${LOG_ANALYTICS_NAME} --query "id" --output tsv)

# AKS クラスターの作成
az aks create \
  -g ${RESOURCE_GROUP} \
  -n ${AKS_NAME} \
  -k ${KUBERNETES_VERSION} \
  --service-principal ${SERVICE_PRINCIPAL} --client-secret ${CLIENT_SECRET} \
  --node-count ${NODE_COUNT} \
  --node-vm-size ${NODE_SIZE} \
  --vm-set-type VirtualMachineScaleSets \
  --load-balancer-sku standard \
  --network-plugin azure \
  --vnet-subnet-id ${SUBNET_ID} \
  --docker-bridge-address ${DOCKER_BRIDGE_ADDRESS} \
  --dns-service-ip ${DNS_SERVICE_IP} \
  --service-cidr ${SERVICE_CIDR} \
  --enable-addons monitoring \
  --workspace-resource-id ${WORKSPACE_RESOURCE_ID} \
  --generate-ssh-keys

# Kubernetes の資格情報を取得
az aks get-credentials -n ${AKS_NAME} -g ${RESOURCE_GROUP}

# Kubernetes ダッシュボードの設定
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

#!/bin/bash

# リソース名の定義
PREFIX=nvx-appgw
LOCATION=eastus
RESOURCE_GROUP=${PREFIX}
VNET_NAME=${PREFIX}-vnet
SUBNET_NAME_APPGW=appgw-subnet
PIP_NAME=appgw-pip
APPGW_NAME=${PREFIX}

# Application Gateway のネットワーク設計
VNET_ADDRESS_PREFIX=10.2.0.0/16
SUBNET_PREFIX_APPGW=10.2.0.0/24

# リソースグループの作成
az group create -n ${RESOURCE_GROUP} -l ${LOCATION}

# 仮想ネットワークの作成
az network vnet create -g ${RESOURCE_GROUP} -n ${VNET_NAME} \
--address-prefix ${VNET_ADDRESS_PREFIX} \
--subnet-name ${SUBNET_NAME_APPGW} \
--subnet-prefix ${SUBNET_PREFIX_APPGW}

az network public-ip create -g ${RESOURCE_GROUP} -n ${PIP_NAME} \
--allocation-method Static \
--sku Standard

az network application-gateway create -g ${RESOURCE_GROUP} -n ${APPGW_NAME} \
--capacity 1 \
--sku Standard_v2 \
--vnet-name ${VNET_NAME} \
--subnet ${SUBNET_NAME_APPGW} \
--public-ip-address ${PIP_NAME} \
--location ${LOCATION}



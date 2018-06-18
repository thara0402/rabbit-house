#!/bin/bash

docker run -it --rm -v ${HOME}/.kube:/root/.kube -v ${HOME}/develop:/develop thara0402/azure-cli-k8s:latest /develop/rabbit-house/azure-cli

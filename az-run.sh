#!/bin/bash

docker run -it --rm -v ${HOME}/.kube:/root/.kube -v ${HOME}/develop:/develop thara0402/azure-cli-k8s:latest
#docker run -it --rm -v ${HOME}/.kube:/root/.kube -v ${HOME}/develop:/develop azuresdk/azure-cli-python:latest

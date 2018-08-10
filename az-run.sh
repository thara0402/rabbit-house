#!/bin/bash

docker run -it --rm -v ${HOME}/.kube:/root/.kube -v ${HOME}/develop:/develop azuresdk/azure-cli-python:latest

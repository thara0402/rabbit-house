#!/bin/bash

export POD_NAME=$(kubectl get pods --namespace default -l "app=my-gf-grafana,component=grafana" -o jsonpath="{.items[0].metadata.name}")

kubectl --namespace default port-forward $POD_NAME 3000

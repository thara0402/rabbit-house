#!/bin/bash

helm install --name my-gf --set server.adminPassword=admin,server.persistentVolume.storageClass=default stable/grafana

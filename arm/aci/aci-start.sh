#!/usr/bin/env bash
for aci in $(az container list --resource-group $1 --query "[].name" -o tsv); do
    az container start -g $1 -n $aci --no-wait
    echo $aci starting...
done
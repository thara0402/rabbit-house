#!/bin/bash
echo "Getting the status of Azure Container Instances..."
az container list --resource-group $1 --query "[].id" -o tsv | xargs -I {} -P 10 az container show --query "{name:name,state:instanceView.state}" -o tsv --ids "{}"
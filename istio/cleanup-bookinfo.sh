#!/bin/bash

cd `dirname $0`
cd istio-0.8.0

kubectl delete -f samples/bookinfo/routing/route-rule-all-v1.yaml
kubectl create -f samples/bookinfo/routing/route-rule-all-v1.yaml

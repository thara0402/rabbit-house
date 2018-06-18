#!/bin/bash

cd `dirname $0`
cd istio-0.8.0

kubectl get svc -n istio-system|grep gateway

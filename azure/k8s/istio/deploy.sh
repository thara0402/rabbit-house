#!/bin/bash

cd `dirname $0`
cd istio-0.8.0

# Istio
#helm template install/kubernetes/helm/istio --name istio --namespace istio-system --set sidecarInjectorWebhook.enabled=false > $HOME/istio.yaml
helm template install/kubernetes/helm/istio --name istio --namespace istio-system --set sidecarInjectorWebhook.enabled=false > ./istio.yaml
kubectl create namespace istio-system
kubectl apply -f ./istio.yaml

# Jaeger
kubectl apply -n istio-system -f https://raw.githubusercontent.com/jaegertracing/jaeger-kubernetes/master/all-in-one/jaeger-all-in-one-template.yml

# Bookindo
kubectl apply -f <(bin/istioctl kube-inject -f samples/bookinfo/kube/bookinfo.yaml)
kubectl create -f samples/bookinfo/routing/bookinfo-gateway.yaml
kubectl create -f samples/bookinfo/routing/route-rule-all-v1.yaml

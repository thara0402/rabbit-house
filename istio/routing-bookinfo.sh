#!/bin/bash

cd `dirname $0`
cd istio-0.8.0

kubectl replace -f samples/bookinfo/routing/route-rule-reviews-50-v3.yaml

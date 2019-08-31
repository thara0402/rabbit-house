#!/bin/bash

helm install --name my-prom stable/prometheus -f values.yaml

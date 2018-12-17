# Fluentd helm chart

## Prerequisites

Get CLUSTER-IP

```shell-session
$ kubectl get svc logging-elasticsearch --no-headers=true | awk '{print $3}'


$ helm install --name logging-fluentd fluentd

```




## Configuration

# Kibana


## Prerequisites

Get CLUSTER-IP

```shell-session
$ kubectl get svc logging-elasticsearch --no-headers=true | awk '{print $3}'


$ helm install --name logging-kibana kibana

```




## Configuration

## Run

```shell
$ kubectl --namespace default port-forward logging-kibana-64778cf589-4lc6h 5601
```


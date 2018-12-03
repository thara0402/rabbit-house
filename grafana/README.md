# Grafana

## DownLoad Helm charts

```shell
$ helm fetch --untar stable/grafana
```

## Configuration

Edit values.yaml

Parameter | Description | Default
--------- | ----------- | -------
`server.image` | Grafana Docker image | `grafana/grafana:5.3.4`
`adminPassword` | Set default password for login Grafana | `admin`
`server.persistentVolume.storageClass` | Data Persistent Volume Storage Class | `default`

## Install

```shell
$ helm install --name monitoring-gra stable/grafana -f values.yaml
```

## Run

```shell
$ kubectl --namespace default port-forward monitoring-gra-grafana-9b69dc44-ghg7l 3000
```

## Data Source
Type: Prometheus
URL: http://monitoring-prom-prometheus-server:80

## Dashboards

https://grafana.com/dashboards?utm_source=grafana_search

Using Grafana Dashboards.  
[Kubernetes cluster monitoring (via Prometheus)](https://grafana.com/dashboards/315)


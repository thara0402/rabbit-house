# How to use Kubernetes

```shell-session
root@fumidai:~# history
    1  apt update
    2  apt upgrade
    3  apt-get install     apt-transport-https     ca-certificates     curl     software-properties-common
    4  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    5  add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
    6  apt-get update
    7  apt-get install docker-ce
    8  docker
    9  docker version
   10  history
```

```shell-session
docker rm $(docker ps -aq)
docker images | awk ‘/<none/{print $3}’ | xargs docker rmi


#!/bin/bash
set -e

if [ "$1" = "" ]
then
    echo "./build-create.sh [version-number]"
    exit 1
fi
export VERSION=$1

DOCKER_IMAGE=tyoshio2002/account-service
DOCKER_REPOSITORY=yoshioreg.azurecr.io

# Build docker image
docker build -t $DOCKER_IMAGE:$VERSION .
docker tag $DOCKER_IMAGE:$VERSION $DOCKER_REPOSITORY/$DOCKER_IMAGE:$VERSION

# Push the image to Private Docker Registry
docker push $DOCKER_REPOSITORY/$DOCKER_IMAGE:$VERSION

# Change the version for docker image inside of YAML file 
sed -i -e "s|image: .*|image: $DOCKER_REPOSITORY/$DOCKER_IMAGE:${VERSION}|g" create-deployment-svc.yaml

# Apply the new Image to the Service
/usr/local/bin/kubectl apply --record -f create-deployment-svc.yaml
#/usr/local/bin/kubectl apply --record -f <(/usr/local/bin/istioctl kube-inject -f ./create-deployment-svc.yaml)


# Clean the image
docker rm $(docker ps -aq)
docker images | awk '/<none/{print $3}' | xargs docker rmi 
```



az login --use-device-code

Windows
```shell-session
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.11.3/bin/windows/amd64/kubectl.exe
```

Mac
```shell-session
$ which kubectl
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.11.3/bin/darwin/amd64/kubectl
$ chmod +x ./kubectl
$ mv ./kubectl /usr/local/bin/kubectl
```

トラブルシュートコマンド
```shell-session
$ kubectl describe pod
$ kubectl logs POD_NAME
$ kubectl exec -it POD_NAME /bin/sh
$ kubectl get events -w
$ Ubuntuを同一名前空間にデプロイ
```

```shell-session
$ history
$ !113
```

```shell-session
$ kubectl run demo-nginx --image nginx
$ kubectl get all -n default
$ kubectl expose deployments demo-nginx --port=80 --type=LoadBalancer
$ kubectl get svc -w
$ kubectl scale deployment demo-nginx --replicas=3
$ kubectl get deploy demo-nginx -o yaml
```

```shell-session
$ docker build -t thara0402/k8sdemo:0.7.0 ./
$ docker run --rm -it -p 8000:80 --name k8sdemo thara0402/k8sdemo:0.7.0
$ docker push thara0402/k8sdemo:0.7.0
```

```shell-session
$ kubectl apply -f deployment.yaml
$ kubectl apply -f service.yaml
```

```shell-session
$ helm init
$ helm instll -n <release name> <charts name>
$ helm delete <release name> --purge
$ helm fetch --untar stable/nginx-ingress
```

```shell-session
$ helm install -n rp stable/nginx-ingress --set rbac.create=false
```


```csharp
public void Configure(IApplicationBuilder app, IHostingEnvironment env)
{
    app.UsePathBase("/foo");    // add code.
}
```

livenessProbe
アプリの死活監視
エラーの場合、k8sがPodを再起動してくれる

readinessProbe
リクエストを受け付けられる状態の監視
エラーの場合、k8sがリクエストを投げないようにしてくれる

共通する設定
initialDelaySeconds
timeoutSeconds
periodSeconds
failureThreshold
https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/#define-readiness-probes


Resource Request
アプリを動かすために最低限必要なリソース
ノードのリソースが足りない場合、アプリをエラーにせず、Pendingにするために設定する
Pendingだと、ノードが追加されるなど空きリソースができ次第、再デプロイされる（スケジューリング）
Resurce Limits
アプリが利用できるリソースの上限値
CPUが超えると遅くなる、メモリが超えるとPODが再起動される
cpu 200m は200 millicoresの略で1000milli coreで1cpu。200 mill coreで 1/5 CPU使うということ

```shell-session
$ kubectl describe node
```
https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/


Istio
```shell-session
$ kubectl apply -f install/kubernetes/istio-demo.yaml
$ kubectl get svc -n istio-system
$ kubectl get pod -n istio-system
```

for windows
```shell-session
$ istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml > bookinfo_inject.yaml
$ kubectl apply -f bookinfo_inject.yaml
```

for MAC
```shell-session
$ kubectl create -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml)
```

```shell-session
$ kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
$ kubectl get gateway
$ kubectl get virtualservice
$ kubectl get svc istio-ingressgateway -n istio-system
$ kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
$ kubectl get destinationrules -o yaml
```

```shell-session
$ kubectl apply -f samples/bookinfo/networking/virtual-service-all-v1.yaml
$ kubectl describe virtualservices reviews
$ kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-50-v3.yaml
$ kubectl describe virtualservices reviews
$ kubectl apply -f samples/bookinfo/networking/virtual-service-reviews-v3.yaml
```

jaeger
```shell-session
$ kubectl get pod -n istio-system -l app=jaeger -o jsonpath='{.items[0].metadata.name}'
$ kubectl port-forward -n istio-system istio-tracing-7596597bd7-8hn9w 16686:16686
```
http://localhost:16686

Grafana
```shell-session
$ kubectl -n istio-system get svc prometheus
$ kubectl -n istio-system get svc grafana
$ kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}'
$ kubectl port-forward -n istio-system grafana-59b787b9b-c5fbr 3000:3000
```
http://localhost:3000

ServiceGraph
```shell-session
$ kubectl -n istio-system get svc servicegraph
$ kubectl -n istio-system get pod -l app=servicegraph -o jsonpath='{.items[0].metadata.name}'
$ kubectl port-forward -n istio-system servicegraph-758f96bf5b-x2ggt 8088:8088
```
http://localhost:8088/force/forcegraph.html



Istio for ASP.NET Core
```shell-session
$ kubectl get deploy demo-deployment -o yaml > demo_current.yaml
$ istioctl kube-inject -f demo_current.yaml > demo_inject.yaml
$ kubectl apply -f demo_inject.yaml

$ kubectl get deploy demo-deployment-v2 -o yaml > demo_current2.yaml
$ istioctl kube-inject -f demo_current2.yaml > demo_inject2.yaml
$ kubectl apply -f demo_inject2.yaml

$ kubectl apply -f service.yaml

$ kubectl apply -f gateway.yaml
$ kubectl get gateway
$ kubectl apply -f virtualservice.yaml
$ kubectl get virtualservice

$ kubectl apply -f destination.yaml
$ kubectl apply -f virtual-service-v1.yaml
$ kubectl apply -f virtual-service-50-v2.yaml
$ kubectl apply -f virtual-service-v2.yaml
```



課題
・IstioのVSでパスを指定すると404

環境構築
　k8s構造レクチャ
　AKS、ACR、inglressでRP、複数サービス
　事前検証項目
　　k8sのみのバージョン切り替え、APP Gateway、接続文字列をSecret
　　Label selecter
サービス展開
　Helm、AzureDevOps、Istio
　事前検証項目
　　Istioカナリアデプロイ
    HorizontalPodAutoscaler、ノードのオートスケール
運用監視
　Azure Monitor、EFK、ProGra
　事前検証項目
　　Azure Monitorの使い方、EFKデプロイ、ProGraデプロイ、Proアラート
　　limit、オートスケール、分散トレーシング（応答時間監視）


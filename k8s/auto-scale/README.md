# Auto Scale with Azure Kubernetes Services

## 事前準備
オートスケーリングを実行させるためには、デプロイする Pod に対して、下記の設定を行っていることが必須条件となります。

- Resource Requests  
Pod を実行するために必要な Memory と CPU のサイズ
- Resource Limit  
Pod が利用できる Memory と CPU の上限サイズ

Deployment.yaml における設定例。
```yaml
resources:
    requests:
    cpu: "100m"
    limits:
    cpu: "200m"
```

## Cluster Autoscaler
### 設定
構築するリソース群の名前とネットワーク構成を設計し、[create-aks.sh](./node/create-aks.sh) の変数値を編集してから、２つのパラメータを指定して実行します。
| パラメータ | パラメータ値 |
----|---- 
| 1 | サービスプリンシパルの appId |
| 2 | サービスプリンシパルの secret(password) |

このスクリプトでは、Node 数を 1 台で作成し、最大 3 台までオートスケーリングさせる設定となっています。

```shell-session
$ ./create-aks.sh <appId> <secret>
```

### 確認
1 台の Node には配置できない Pod をデプロイすることで、Status が Pending の状態を作り、オートスケーリングを発動させます。

```shell-session
$ kubectl apply -f deployment.yaml
deployment.apps/nginx created

$ kubectl get nodes
NAME                                STATUS   ROLES   AGE   VERSION
aks-nodepool1-23235296-vmss000000   Ready    agent   47h   v1.15.10

$ kubectl get pod -o wide
NAME                     READY   STATUS    RESTARTS   AGE   IP          NODE                                NOMINATED NODE   READINESS GATES
nginx-74bc88576b-8l4tl   1/1     Running   0          53s   10.0.0.14   aks-nodepool1-23235296-vmss000000   <none>           <none>
nginx-74bc88576b-fqxft   0/1     Pending   0          53s   <none>      <none>                              <none>           <none>
nginx-74bc88576b-gvhwr   1/1     Running   0          53s   10.0.0.5    aks-nodepool1-23235296-vmss000000   <none>           <none>
nginx-74bc88576b-htlzd   0/1     Pending   0          53s   <none>      <none>                              <none>           <none>
nginx-74bc88576b-rspkk   1/1     Running   0          53s   10.0.0.30   aks-nodepool1-23235296-vmss000000   <none>           <none>

$ kubectl get nodes
NAME                                STATUS   ROLES   AGE   VERSION
aks-nodepool1-23235296-vmss000000   Ready    agent   47h   v1.15.10
aks-nodepool1-23235296-vmss000002   Ready    agent   69s   v1.15.10
```

## Horizontal Pod autoscaler
### 設定
オートスケーリングさせる Deployment に対して、Horizontal Pod autoscaler を設定します。
```shell-session
$ kubectl apply -f deployment.yaml
$ kubectl apply -f hpa.yaml
```
上記の例では、CPU 利用率が 30% を超えた場合、Pod 数を 1 ～ 3 までオートスケーリングさせる設定となっています。

### 確認
Pod の CPU 利用率を上昇させるため、kubectl exec コマンドで強制的に負荷をかけて、オートスケーリングを発動させます。

```shell-session
$ kubectl exec -it nginx-6858db9547-2st67 /bin/sh
# for i in {0..9}; do nohup `while :; do echo 1 > /dev/null; done;` & done

$ kubectl top pod
NAME                     CPU(cores)   MEMORY(bytes)
nginx-6858db9547-2st67   101m         3Mi

$ kubectl get pod,hpa
NAME                         READY   STATUS              RESTARTS   AGE
pod/nginx-6858db9547-2st67   1/1     Running             0          2m28s
pod/nginx-6858db9547-lctsg   0/1     ContainerCreating   0          1s
pod/nginx-6858db9547-tkvpx   0/1     ContainerCreating   0          1s

NAME                                            REFERENCE          TARGETS    MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/nginx-hpa   Deployment/nginx   101%/30%   1         3         1          2m3s
```

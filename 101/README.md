# How to use Kubernetes

kubectl exec -it POD_NAME /bin/sh
kubectl get events

curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.11.3/bin/darwin/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
which kubectl

kubectl get svc -w

history
!113

helm install stable/nginx-ingress --set rbac.create=false

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


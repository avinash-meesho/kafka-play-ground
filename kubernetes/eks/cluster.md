## Cluster Creation
Creation
```
eksctl create cluster -f cluster.yaml --profile confluent
```
deletion
```
eksctl delete cluster -f cluster.yaml --profile confluent
```
​
## Init Kubectl config
See https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html
​
```bash
aws --version
aws eks update-kubeconfig --region ap-southeast-2 --name shin-eks-cluster --profile confluent


kubectl create ns confluent --kubeconfig ~/.kube/config

kubectl config set-context --current --namespace=confluent

helm repo add confluentinc https://packages.confluent.io/helm

helm upgrade --install operator confluentinc/confluent-for-kubernetes 

```

##
Dashboard
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.1/aio/deploy/recommended.yaml
kubectl proxy
```
Dashboard at [http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/)

Non-secure API token
```
kubectl get secret confluent-for-kubernetes-token-9hd2c -o yaml
```
Decode the token from base64
```
echo ${token} | base64 -d
```


```
eksctl create cluster -f singapore.yaml --profile confluent

eksctl create cluster -f sydney.yaml --profile confluent

eksctl create cluster -f tokoy.yaml --profile confluent

```


```
aws eks update-kubeconfig --region ap-southeast-1 --name shin-eks-sin-cluster --alias mcr-sin
aws eks update-kubeconfig --region ap-southeast-2 --name shin-eks-syd-cluster --alias mcr-syd
aws eks update-kubeconfig --region ap-northeast-1 --name shin-eks-tky-cluster --alias mcr-tky


kubectl create ns sin --contex mrc-sin
kubectl create ns syd --contex mrc-syd
kubectl create ns tky --contex mrc-tky
```

eksctl delete cluster -f sydney.yaml --profile confluent

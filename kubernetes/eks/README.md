
# Introduction


# EKS Setup

### Cluster Creation
```
eksctl create cluster -f cluster.yaml --profile confluent
```

### Kubectl Configuration
​See More in [https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)
​
```bash
aws --version
aws eks update-kubeconfig --region ap-southeast-2 --name shin-eks-cluster --profile confluent
```

# Setup Kubernetes Dashboard

### Install and Proxy to local
``` bash
kubectl apply -f dashboard.yaml
kubectl proxy
```

View Dashboard via Proxy  at [http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/)

Copy token for Dashboard
```
bin/copy_token
```

# Setup Confluent For Kafka
```
# create `confluent` namespace in Kubenetes 
kubectl create ns confluent --kubeconfig ~/.kube/config

# set `confluent` as the default namespace in kubectl
kubectl config set-context --current --namespace=confluent

# add confluent helm repo
helm repo add confluentinc https://packages.confluent.io/helm
helm repo update

# install CFK to confluent namespace on EKS
helm upgrade --install confluent-operator \
  confluentinc/confluent-for-kubernetes \
  --namespace confluent
```

# Install Confluent Patform via CFK
```
kubectl apply -f confluent-platform.yaml
```
This will install the Confluent Platform in `confluent` namespace. The `externalDNS` has been enabled. All the services will have an AWS public DNS and the default DNS suffixed with `eks.shin.ps.confluent.io`.

Once all the loadbalancers are ready in
```
kubectl get services -n confluent | grep LoadBalancer
```
we can create the terraform code to build the external DNS for our services
```
bin/create_dns
```

Then we can execute the terraform DNS builder under `dns-terraform` folder
```
terraform init
terraform apply --auto-approve
```

## Monitoring

Add Prometheus and Grafana helm repo
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts

helm repo update
```

Installa Prometheus and Grafana
```
helm upgrade --install prometheus prometheus-community/prometheus

helm upgrade --install grafana grafana/grafana
```

Get Grafana Password
```
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```
Prometheus: [http://localhost:8001/api/v1/namespaces/confluent/services/http:prometheus-server:80/proxy](http://localhost:8001/api/v1/namespaces/confluent/services/http:prometheus-server:80/proxy)

Grafana: 

```
export POD_NAME=$(kubectl get pods --namespace confluent -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")

kubectl --namespace confluent port-forward $POD_NAME 3000
```
login password for `admin` can be obtained via
```
kubectl get secret grafana -o jsonpath="{.data.admin-password}" | base64 -d
```

Import Grafana Dashboard from `monitoring/confluent-platform.json`

## Custom Resource Definitions
```
# View Custom Resource Def
kubectl api-resources --api-group=platform.confluent.io

kubectl explain kafka.spec.podTemplate
```

# Destroy Cluster
```
# Delete CP Cluster
kubectl delete -f confluent-platform.yaml

# Delete Prometheus and Grafana
helm uninstall prometheus
helm uninstall grafana

# Delete DNS
cd dns-terraform
terraform destroy --auto-approve

# Delete EKS

eksctl delete cluster -f cluster.yaml --profile confluent
```
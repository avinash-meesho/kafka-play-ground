# AWS VPC peering

## Confluent Platform

Region: ap-southeast-2
Installation: [cp-ansible](https://github.com/confluentinc/cp-ansible)
Internet access: No
VPC cidr: 10.0.0.0/16

## Confluent Cloud

Region: ap-southeast-2
Internet access: No
VPC cidr: 10.10.0.0/16

## Peering
1. Request VPC peering from CC
2. Accept VPC peering in CP
3. Setup route table in CP VPC:
```
10.10.0.0/16 to vpx
```

## Configure control center & broker proxy

get `CC_hostname` from Confluent Cloud cluster page. E.g: 
```
pkac-9g11v.ap-southeast-2.aws.confluent.cloud
```

Setup local host configuration
```
tee -a /etc/hosts << END
{{ bastion_host_ip }}   {{ CC_hostname }}
END
```

Setup haproxy on bastion host in AWS
```
sudo tee -a /etc/haproxy/haproxy.cfg << END
frontend ccc3FE
    bind :443
    option tcplog
    mode tcp
    default_backend ccc3BE

backend ccc3BE
   mode tcp
   server ccc3 {{ CC_hostname }}:443 check

frontend ccbrokerFE
    bind :9092
    option tcplog
    mode tcp
    default_backend ccbrokerBE

backend ccbrokerBE
   mode tcp
   server ccbroker {{ CC_hostname }}:9092 check
END

sudo systemctl restart haproxy
```



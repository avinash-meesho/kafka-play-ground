# Confluent Platform on AWS

## Usage

### 1. Provision AWS resources
This will provide VPC, subnets, security group and EC2 instances for Confluent Platform
```
terraform init
terraform apply --auto-approve
```

### 2. Construct inventory file for cp-ansible
The following commands will use the terraform output to build an inventory file - `tmp/hosts.yml`
```
bin/output_json aws
bin/extract_hosts aws sasl-ssl
bin/generate_certs
```

### 3. Setup bastion host
Copy SSH key and inventory file to bastion host and setup the bastion host with required tools
```
bin/remote_commands aws bastion-0.shin.ps.confluent.io shin-test-key.pem
```
The following fields in `resources/remote_commands.txt` and `bin/remote_commands` need to be modified:

- SSH key name
- Confluent Control Center (c3) internal DNS

### 4. Install Confluent Platform

Test ansible connectivity to hosts
```
ansible -i hosts.yml all -m ping
```
Install Confluent Platform
``` 
ansible-playbook -i hosts.yml confluent.platform.all
```
(optional) Stop components of Confluent Platform if you encounter validation errors on `not enough memory`
```
ansible-playbook -i hosts.yml cp-stop.yml --tags control_center
```

### 5. Setup control center proxy on bastion host
```
sudo tee -a /etc/haproxy/haproxy.cfg << END
# c3FE
frontend c3FE
    bind :9021
    option tcplog
    mode tcp
    default_backend c3BE

# c3BE
backend c3BE
   mode tcp
   server c3 c3-0.shin.ps.confluent.io:9021 check
END

sudo systemctl restart haproxy
```

verify the cluster in browser
```
http://shin.aws:9021
```
# syt5-gek1031-infrastructure-as-code-dahgao-gek1031

## About

Ansible is an automation tool that helps you manage and configure servers without needing extra software on them.
It uses simple files to define what needs to be done. 
It is idempotent, which means that it knows, which steps have to be executed, and which steps can be skipped.

**This project showcases the usage of Ansible** (https://docs.ansible.com/) to :
- configure 3 existing VMs:
    - 2 VMs with a webserver (nginx)
    - 1 VM with a load balancer (HAProxy)
- deploy our JWT exercise (https://github.com/TGM-HIT/syt5-gek961-cloud-datenmanagement-dahmen_gao) on a VM

Terraform is a tool that allows you to create and manage cloud resources with configuration files,
making it easier to set up and change infrastructure. 
This means that it can contact platforms such as AWS or Hetzner to create machines.

The **project also shows the usage of Terraform** (https://developer.hashicorp.com/terraform) and Hetzner (https://www.hetzner.com/) to:
- set up 2 webservers with nginx
- set up a load balancer

## Usage

### load balancer

1. Enter the IP adresses of your VMs in `load-balancing/inventory.ini`
2. Execute the following code:

```bash
cd load-balancing

# replace your-user
user='your-user'
ansible-playbook -i inventory.ini playbook.yaml -u $user
```

### jwt 

1. Enter the IP adress in `jwt/inventory.ini`
2. Copy your .env file from the JWT exercise to `jwt/.env`
3. Execute:

```bash
cd jwt

user='your-user'
ansible-playbook -i inventory.ini playbook.yaml -u $user
```

### terraform

1. Set your hcloud token as the environment variable `HCLOUD_TOKEN`
2. Upload your SSH public key to Hetzner
3. Change the `ssk_keys` in `main.tf` to the name of your SSH key on Hetzner
4. Execute:

```bash
cd terraform
terraform init
terraform apply
```

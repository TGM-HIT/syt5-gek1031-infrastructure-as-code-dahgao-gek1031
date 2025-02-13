# syt5-gek1031-infrastructure-as-code-dahgao-gek1031

## About

This project showcases the usage of Ansible (https://docs.ansible.com/) to :
- configure 3 existing VMs:
    - 2 VMs with a webserver (nginx)
    - 1 VM with a load balancer (HAProxy)
- deploy our JWT exercise (https://github.com/TGM-HIT/syt5-gek961-cloud-datenmanagement-dahmen_gao) on a VM


## Usage

### load balancer

1. Enter the IP adresses of your VMs in `inventory.ini`
2. Execute the following code:

```bash
cd load-balancing

# replace your-user
user='your-user'
ansible-playbook -i inventory.ini playbook.yaml -u $user
```

### jwt 

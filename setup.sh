#! /bin/bash

sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible --yes

# Get values from config
export $(cat $(dirname -- "$0")/config | xargs)

ansible-playbook ./playbook.yaml -K \
    -e "target=localhost \
        gateway=$DEV_IP_GATEWAY \
        interface=$DEV_IP_INTERFACE \
        ip=$DEV_IP_ADDRESSS \
    "

# Run docker commands without sudo
sudo usermod -aG docker $USER
newgrp docker

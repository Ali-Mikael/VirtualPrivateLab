# -*- mode: ruby -*-
# vi: set ft=ruby :

$initscript = <<INITSCRIPT
set -o verbose
mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
sudo apt update
INITSCRIPT

$minion = <<MINION
sudo apt install salt-minion -y
echo "master: 192.168.88.100" | sudo tee /etc/salt/minion
echo "id: $(hostname)" | sudo tee -a /etc/salt/minion
sudo systemctl restart salt-minion
MINION

$master = <<MASTER
sudo apt install salt-master -y
sudo systemctl enable salt-master && sudo systemctl start salt-master
MASTER

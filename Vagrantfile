# -*- mode: ruby -*-
# vi: set ft=ruby :

$initscript = <<INITSCRIPT
set -o verbose
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl
INITSCRIPT

$minion = <<MINION
curl -L https://bootstrap.saltproject.io -o install_salt.sh
sudo sh install_salt.sh -P
echo "master: 192.168.88.100" | sudo tee /etc/salt/minion
echo "id: $(hostname)" | sudo tee -a /etc/salt/minion
sudo systemctl enable salt-minion
sudo systemctl restart salt-minion
MINION

$master = <<MASTER
curl -L https://bootstrap.saltproject.io -o install_salt.sh
sudo sh install_salt.sh -P -M
echo "auto_accept: True" | sudo tee -a /etc/salt/master
sudo systemctl enable salt-master
sudo systemctl restart salt-master
MASTER


Vagrant.configure("2") do |config|
	config.vm.box = "bento/ubuntu-24.04"
	config.vm.synced_folder ".", "/vagrant", disabled: true
	config.vm.synced_folder "shared/", "/home/vagrant/shared", create: true

	
	config.vm.provider "virtualbox" do |vb|
	  vb.linked_clone = true
	  vb.memory = 1024
	  vb.cpus = 2
	end

	config.vm.define "master", primary: true do |master|
	  master.vm.hostname = "master"
	  master.vm.provision "shell", inline: $master
	  master.vm.network "private_network", ip: "192.168.88.100"
	  master.vm.provision "shell", inline: $initscript
	  master.vm.provision "shell", inline: $master
	end



	(1..3).each do |i|
	  config.vm.define "minion0#{i}" do |minion|
	    minion.vm.hostname = "minion0#{i}"
	    minion.vm.network "private_network", ip: "192.168.88.10#{i}"
	    minion.vm.provision "shell", inline: $initscript
	    minion.vm.provision "shell", inline: $minion
	  end
	end
end

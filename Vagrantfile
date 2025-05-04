# -*- mode: ruby -*-
# vi: set ft=ruby :

# Shell scripts for provisioning
# -----------------------------

$initscript = <<INITSCRIPT
set -o verbose
apt update && apt upgrade -y
apt install -y curl
INITSCRIPT


# Salt-Minion setup script
# -------------------
$minion = <<MINION
curl -o bootstrap-salt.sh -L https://github.com/saltstack/salt-bootstrap/releases/latest/download/bootstrap-salt.sh
sh bootstrap-salt.sh -P
echo "master: 192.168.88.100" >> /etc/salt/minion
echo "id: $(hostname)" >> /etc/salt/minion
systemctl enable salt-minion
systemctl restart salt-minion
MINION

# Salt-Master setup script
# ------------------------
$master = <<MASTER
curl -o bootstrap-salt.sh -L https://github.com/saltstack/salt-bootstrap/releases/latest/download/bootstrap-salt.sh
sh bootstrap-salt.sh -P -M
echo "interface: 192.168.88.100" >> /etc/salt/master
echo "auto_accept: True" >> /etc/salt/master
mkdir -p /srv/salt
systemctl enable salt-master
systemctl restart salt-master
MASTER



# Vagrant configuration for the VMS
# ----------------------------------- 

Vagrant.configure("2") do |config|
	
	# Using Bento's ubuntu 24.04 for the base box
	config.vm.box = "bento/ubuntu-24.04"

	# Sync salt states folder to /srv/salt on the master VM
	config.vm.synced_folder "./salt", "/srv/salt"

	# Virtualbox specific configurations for VMs
	config.vm.provider "virtualbox" do |vb|
	  vb.linked_clone = true	# Use linked clones to speed up VM creation
	  vb.memory = 1024		# Set 1024mb of RAM
	  vb.cpus = 2			# Number of CPUs = 2
	end

	
	# Defining the Salt-master
	# ------------------------
	config.vm.define "master", primary: true do |master|
	  master.vm.hostname = "master"
	  master.vm.network "private_network", ip: "192.168.88.100"

	  # Provision the master VM
	  master.vm.provision "shell", inline: $initscript
	  master.vm.provision "shell", inline: $master
	end


	# Defining the Salt-minions
	(1..3).each do |i|
	  config.vm.define "minion0#{i}" do |minion|
	    minion.vm.hostname = "minion0#{i}"
	    minion.vm.network "private_network", ip: "192.168.88.10#{i}"

	    # Provision each minion VM
	    minion.vm.provision "shell", inline: $initscript
	    minion.vm.provision "shell", inline: $minion
	  end
	end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :


# Basic provision script to be used for all VMs
# ---------------------------------------------

$initscript = <<INITSCRIPT
set -o verbose
apt update && apt upgrade -y
apt install -y curl
INITSCRIPT


# Salt-Minion provision script
# ----------------------------

$minion = <<MINION
# > Installing salt using the bootstrap method 
# > It's a lighweight version for test/dev environments so some modules need to be installed manually
# > See https://docs.saltproject.io/salt/install-guide/en/latest/ for more
curl -o bootstrap-salt.sh -L https://github.com/saltstack/salt-bootstrap/releases/latest/download/bootstrap-salt.sh
sh bootstrap-salt.sh -P

# > Giving the minion contact details for the master
echo "master: 192.168.88.100" >> /etc/salt/minion
echo "id: $(hostname)" >> /etc/salt/minion

# > Enabling and restarting the service so the configurations take place
systemctl enable salt-minion
systemctl restart salt-minion
MINION


# Salt-Master setup script
# ------------------------

$master = <<MASTER

# > Same as with the minions, using the lightweight bootstrap method
curl -o bootstrap-salt.sh -L https://github.com/saltstack/salt-bootstrap/releases/latest/download/bootstrap-salt.sh
sh bootstrap-salt.sh -P -M

# > Specifying the masters ip-address to the config file and auto accepting minion-keys
# > Note: Auto accepting should only be done in test/dev environments, not for production!
echo "interface: 192.168.88.100" >> /etc/salt/master
echo "auto_accept: True" >> /etc/salt/master

# > Creating the file_roots path for salt and telling it where to look
mkdir -p /srv/salt
echo "file_roots:" >> /etc/salt/master.d/file_roots.conf
echo "  base:" >> /etc/salt/master.d/file_roots.conf
echo "    - /srv/salt" >> /etc/salt/master.d/file_roots.conf

# > Enable and restart for configs to take place
systemctl enable salt-master
systemctl restart salt-master
MASTER



# Vagrant configuration for the VMS
# ----------------------------------- 

Vagrant.configure("2") do |config|
	
	# Using Bento's ubuntu 24.04 for the base box
	config.vm.box = "bento/ubuntu-24.04"

        # Disable VBox shared folder (using rsync instead)
        config.vm.synced_folder ".", "/vagrant", disabled: true

	# Virtualbox specific configurations for VMs
	config.vm.provider "virtualbox" do |vb|
	  vb.linked_clone = true	# Use linked for more agile/speedy VM creation
	  vb.memory = 1024		# Set 1024mb of RAM
	  vb.cpus = 2			# Number of CPUs = 2
	end

	
	# Defining the Salt-master
	# ------------------------
	config.vm.define "master" do |master|
	  master.vm.hostname = "master"
	  master.vm.network "private_network", ip: "192.168.88.100"

          # Syncing the repo salt folder to salt-master under /srv/salt (the file roots path)
          # Use rsync instead of VBadditions syncing
          master.vm.synced_folder "./salt", "/srv/salt", type: "rsync", rsync__auto: true

	  # Provision the master VM
	  master.vm.provision "shell", inline: $initscript
	  master.vm.provision "shell", inline: $master
	end


	# Defining Salt-minions
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

# -*- mode: ruby -*-
# vi: set ft=ruby :


# Basic setup script for all VMs
# ------------------------------
$initscript = <<-'INITSCRIPT'
  set -o verbose
  apt update && apt upgrade -y
  apt install -y curl tree gnupg
INITSCRIPT


# Install Salt
# ---------------

# Using bootstrap method
$salt_install_bootstrap = <<-'SCRIPT'
  # If using bootstrap method remove "apt install" from the Minion/Master script
  # See https://docs.saltproject.io/salt/install-guide/en/latest/ for more
  curl -o bootstrap-salt.sh -L https://github.com/saltstack/salt-bootstrap/releases/latest/download/bootstrap-salt.sh
  sh bootstrap-salt.sh -P
SCRIPT


# Using APT
$salt_install_apt = <<-'SCRIPT'
  # Ensure keyrings dir exists
  mkdir -p /etc/apt/keyrings

  # Copy SaltProject pub key to keyrings dir  
  cp /home/vagrant/files/SaltProjectKey.gpg.pub /etc/apt/keyrings/salt-archive-keyring.pgp

  # Create apt repo target configuration
  curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources > /dev/null

  # Update metadata
  apt update
SCRIPT

# Salt-Minion setup script
# ------------------------
$minion = <<-'MINION'
  # Install the salt-minion
  apt install salt-minion -y

  # Configure Master contact details and hostname for the minion
  echo "master: 192.168.88.100" >> /etc/salt/minion
  echo "id: $(hostname)" >> /etc/salt/minion

  # Enable and restart service for configs to take place
  systemctl enable salt-minion && systemctl restart salt-minion
MINION


# Salt-Master setup script
# ------------------------
$master = <<-'MASTER'
  # Installing salt-master
  apt install salt-master -y

  # Specifying the masters ip-address to the config file and auto accepting minion-keys
  # Note: Auto accepting should only be done in test/dev environments, not for production!
  echo "interface: 192.168.88.100" >> /etc/salt/master
  echo "auto_accept: True" >> /etc/salt/master

  # Creating the file_roots path for salt and telling it where to look
  mkdir -p /srv/salt
  echo "file_roots:" >> /etc/salt/master.d/file_roots.conf
  echo "  base:" >> /etc/salt/master.d/file_roots.conf
  echo "    - /srv/salt" >> /etc/salt/master.d/file_roots.conf

  # Ensuring correct permissions
  chown root:root /srv/salt
  chmod 755 /srv/salt

  # Doing the same for pillar
  mkdir -p /srv/pillar
  echo "pillar_roots:" >> /etc/salt/master.d/pillar_roots.conf
  echo "  base:" >> /etc/salt/master.d/pillar_roots.conf
  echo "    - /srv/pillar" >> /etc/salt/master.d/pillar_roots.conf

  # Ensuring correct permissions
  chown root:root /srv/pillar
  chmod 755 /srv/pillar

  # Enable and restart for configs to take place
  systemctl enable salt-master && systemctl restart salt-master
MASTER



# Vagrant configuration for the VMS
# ----------------------------------- 

Vagrant.configure("2") do |config|
	
	# Using Bento's ubuntu 24.04 for the base box
        # Find the box that best suits your needs at:
	# https://portal.cloud.hashicorp.com/vagrant/discover
	config.vm.box = "bento/ubuntu-24.04"

        # Disable VBox shared folder (using rsync instead)
        config.vm.synced_folder ".", "/vagrant", disabled: true
	
	# Syncing /files folder from the repo to vms
	config.vm.synced_folder "./files", "/home/vagrant/files", type: "rsync", rsync__auto: true

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

          # Syncing salt & pillar directories to salt-master
          # Use rsync instead of VBoxAdditions syncing
          master.vm.synced_folder "./salt", "/srv/salt", type: "rsync", rsync__auto: true
	  master.vm.synced_folder "./pillar", "/srv/pillar", type: "rsync", rsync__auto: true

	  # Provision the master VM
	  master.vm.provision "shell", inline: $initscript
          master.vm.provision "shell", inline: $salt_install_apt
	  master.vm.provision "shell", inline: $master
	end


	# Defining Salt-minions
        # ---------------------
	minions = {
	"devbox" => "192.168.88.101",
	"web-serv" => "192.168.88.102",
	"db-serv" => "192.168.88.103"
	}

	minions.each do |name, ip|
	  config.vm.define name do |minion|

	    # Configure names and IP-addressing
	    minion.vm.hostname = name
	    minion.vm.network "private_network", ip: ip

	    # Provision each minion VM
	    minion.vm.provision "shell", inline: $initscript
            minion.vm.provision "shell", inline: $salt_install_apt
	    minion.vm.provision "shell", inline: $minion
	  end
	end
end

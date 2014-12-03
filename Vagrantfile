# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "chef/centos-6.5"

  # Informulate
  config.vm.hostname = "informulate-eipdev"
  config.vm.post_up_message = "Informulate - Smart solutions, strategic partnership"
  config.vm.box_check_update = false
  config.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key','~/.ssh/id_rsa']
  config.ssh.forward_agent = true

  # Guest Apache listening on port 80 can be accessed from the host maching on port 8931
  # by typing localhost:8931.
  config.vm.network :forwarded_port, guest: 80, host: 8931, auto_correct: true

  # This first argument is the host machione folder to be shared with the VM. The 2nd
  # argument is the target. create: true specifies that if the target folder (/var/www)
  # does not exist, then create it automatically.
  #config.vm.synced_folder "./", "/home/vagrant/syncfolder", create: true, group: "www-data", owner: "www-data"

  # Configures the virtual machine itself.
  config.vm.provider "virtualbox" do |v|
    v.name = "Stanford eip.dev"
    v.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # When booting show the booting process instead of silently doing it
  #config.vm.provider "virtualbox" do |vb|
  #   vb.gui = true
  #end
  
  # SSH
  config.ssh.username = "vagrant"
  #config.ssh.forward_x11 = true
  #config.ssh.insert_key = true
  #config.ssh.shell = "bash -l"

  # Shell script provisioning
  config.vm.provision "shell", path: "provision_eipdev.sh", privileged: false
end

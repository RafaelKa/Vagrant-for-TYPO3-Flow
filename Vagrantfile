# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
OS_ARCHITECTURE="64"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #########################################################################
  # All Vagrant configuration is done here. The most common configuration #
  # options are documented and commented below. For a complete reference, #
  # please see the online documentation at vagrantup.com.                 #
  #########################################################################

  # Every Vagrant virtual environment requires a box to build off of.
    # This is the official Ubuntu Server 14.04 image. This box always points to the current version.
    # see https://vagrantcloud.com/ubuntu/trusty64 or https://vagrantcloud.com/ubuntu/trusty32
    # You can change OS architecture if you want using 32 Bit, then change OS_ARCHITECTURE to 32.
  config.vm.box = "ubuntu/trusty" + OS_ARCHITECTURE

#  config.vm.network "forwarded_port", guest: 80, host: 80
#  config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "workspace", "/home/vagrant/workspace"

  ####
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vm|
  ## Don't boot with headless mode
  #  vm.gui = true
  #
  ## Use VBoxManage to customize the VM. For example to change memory:
    vm.customize ["modifyvm", :id, "--memory", "2048"]
  ## todo : save VM in VM_Directory
  end
  ####

  ####
  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.
  #
  config.vm.provision :shell do |shell|
    # todo: move this to module dependencies for puppet
    shell.inline = "puppet module install --force 'puppetlabs/stdlib' --modulepath '/vagrant/puppet/modules'; " +
                   "puppet module install --force 'puppetlabs/apt' --modulepath '/vagrant/puppet/modules'; "
  end

  config.vm.provision "puppet" do |puppet|
  ## todo: configuration.yaml does not work currently
#    puppet.hiera_config_path = "configuration.yaml"
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "trusty.pp"
    puppet.module_path="puppet/modules"
  end
end

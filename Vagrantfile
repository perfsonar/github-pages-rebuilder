#
# Vagrant Configuration for GitHub Pages Rebuilder
#

default_box = "centos/7"

name = "scratch"

Vagrant.configure("2") do |config|

    if Vagrant.has_plugin?("vagrant-vbguest")
      # Don't allow upgrades; the box has what it has.
      config.vbguest.auto_update = false
    end

    # Basic configuration

    config.vm.provider "virtualbox" do |vbox|
      # The default E1000 has a security vulerability.
      vbox.default_nic_type = "82543GC"
      vbox.cpus = 1
      vbox.memory = 512
      config.vm.box = default_box
      config.vm.hostname = name
    end

    config.vm.provision "setup", type: "shell", run: "once", inline: <<-SHELL
      yum -y install make curl yum-cron
      yum -y update
      chown -R vagrant.vagrant /vagrant
      # Run it once to make sure it succeeds, then install.
      su - vagrant -c "make -C /vagrant rebuild"
      su - vagrant -c "make -C /vagrant install"
    SHELL

end


# -*- mode: ruby -*-
# vi: set ft=ruby :

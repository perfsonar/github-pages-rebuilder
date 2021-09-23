#
# Vagrant Configuration for GitHub Pages Rebuilder
#

default_box = "alpine/alpine64"

name = "website-rebuilder"

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

      apk add \
          curl \
          make

      REBUILDER_USER=rebuilder
      adduser -D -g "Perfsonar.net Rebuilder" "${REBUILDER_USER}"
      REBUILDER_HOME=$(getent passwd "${REBUILDER_USER}" | awk -F: '{ print $6 }')
      REBUILDER_DIR="${REBUILDER_HOME}/rebuilder"

      cp -r /vagrant "${REBUILDER_DIR}"
      chown -R "${REBUILDER_USER}.${REBUILDER_USER}" "${REBUILDER_DIR}"

      # Run it once to make sure it succeeds, then install.
      su - "${REBUILDER_USER}" -c "make -C ${REBUILDER_DIR} rebuild"
      su - "${REBUILDER_USER}" -c "make -C ${REBUILDER_DIR} install"
    SHELL

end


# -*- mode: ruby -*-
# vi: set ft=ruby :

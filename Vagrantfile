# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
nodes_config = YAML.load_file('nodes.yaml')['nodes']

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.insert_key = false
  # config.ssh.password   = 'vagrant'
  # config.proxy.http     = "http://10.162.14.16:8080"
  # config.proxy.https    = "http://10.162.14.16:8080"

  nodes_config.each_pair do |vmname, vmspec |

    config.vm.define vmname do |config|
      config.vm.box = vmspec['box']
      # configures all forwarding ports in YAML array
      ports = vmspec['ports']
      ports.each do |port|
        config.vm.network :forwarded_port,
        host_ip: "127.0.0.1",
        host: port['host'],
        guest: port['guest'],
        id:"ssh",
        protocol: "tcp"
      end
      # config.vm.network :forwarded_port, host_ip: "127.0.0.1", host: 3222, guest: 22, protocol: "tcp", id: "ssh"

      config.vm.hostname = vmname
      config.vm.network :private_network, ip: vmspec['ip']
      config.vm.synced_folder ".", "/vagrant", type: vmspec['foldersync']
      config.vm.synced_folder "~/git/datagather", "/vagrant/datagather", type: vmspec['foldersync']
      # config.vm.synced_folder "saltstack/salt/", "/srv/salt", type: "virtualbox"
      # config.vm.synced_folder "saltstack/pillar/", "/srv/pillar", type: "virtualbox"

      # config.vm.provision :shell, :path => vmspec['bootstrap']
      # config.vm.provision :shell do |shell|
      #   shell.path = vmspec['bootstrap']
      #   shell.upload_path = '/opt/vagrant/bootstrap.sh'
      # end
      if !vmspec['initialize'].nil?
        config.vm.provision :shell do |shell|
          shell.path = vmspec['initialize']
        end
        config.vm.provision :shell do |shell|
          shell.path = 'sshagent.sh'
          shell.privileged = false
        end
      end

      if !vmspec['bootstrap'].nil?
        config.vm.provision :shell do |shell|
          shell.path = vmspec['bootstrap']
        end
      end

      if !vmspec['cfgmgmt'].nil?
        config.vm.provision :shell do |shell|
          shell.path = vmspec['cfgmgmt']
        end
      end

      config.vm.provision :hosts do |host|
        host.add_host '10.0.2.2', ['myhost.vagrantup.internal']
        host.autoconfigure = true
        host.sync_hosts = true
      end

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", vmspec['memory']]
        vb.customize ["modifyvm", :id, "--name", vmname]
      end

      # config.vm.provision :salt do |salt|
      #   salt.install_type = "stable"
      #   salt.minion_config = "saltstack/etc/minion"
      #   salt.run_highstate = true
      #   salt.log_level = "warning"
      #   salt.verbose = true
      #   salt.colorize = true
      #   salt.bootstrap_options = "-P -c /tmp"
      # end

    end
  end
end

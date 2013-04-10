# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu12.04_chef-11.2.0"
  config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-11.2.0.box"
  config.vm.network :forwarded_port, guest: 8000, host: 8000, auto_correct: true

  # this block of settings are specific to virtualbox,
  # ignored for other providers
  config.vm.provider :virtualbox do |vb|
    # This setting makes it so that network access from the vagrant guest is able to
    # resolve connections using the hosts VPN connection
    # it means we can DNS resolve internal.vpn domains
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    # This setting gives the VM 1 GB of MEMORIES. Same size as staging machine.
    vb.customize ["modifyvm", :id, "--memory", 1024]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end

  # This setting makes it so that network access from the vagrant guest is
  # able to use the SSH private keys that are present on the host without
  # copying them into the VM.
  # it means we can authenticate to internal.vpn
  config.ssh.forward_agent = true
  # We want this VM to be reachable on the private host network as well,
  # so that the other VM's that are running IE can access our dev server
  config.vm.network :private_network, ip: "192.168.50.50"

  cookbooks_path = ["chef/cookbooks", "chef/site-cookbooks"]

  # the first chef run just upgrades the chef client to the version specified
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = cookbooks_path
    chef.add_recipe "omnibus_updater"
    chef.json = {
      :omnibus_updater => { :version => '11.4.0-1', :install_via => 'deb', :base_uri => 'http://opscode-omnitruck-release.s3.amazonaws.com' }
    }
  end

  # the second chef run will use the updated chef client and
  # do our normal configuration with the latest chef
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = cookbooks_path
    chef.add_recipe "recipe[apt]"
    chef.add_recipe "recipe[build-essential]"
    chef.add_recipe "recipe[unattended-upgrades]"
    chef.add_recipe "recipe[python]"
    chef.add_recipe "recipe[java]"
    chef.add_recipe "recipe[nodejs::install_from_source]"
    chef.add_recipe "recipe[nodejs::npm]"
    chef.add_recipe "recipe[custom]"

    chef.json = {
      :postgresql => {
        :password => {
          :postgres => "letmein"
        }
      },
      :unattended_upgrades => {
        "allowed_origins" => ['${distro_id}:${distro_codename}-security'],
        "mail" => nil
      }
    }
  end
end

#!/usr/bin/env ruby

Vagrant.configure("2") do |config|

  config.vm.hostname = "builder"
  config.vm.box = ENV['VAGRANT_BOX'] || 'opscode_ubuntu-12.04_chef-11.2.0'
  config.vm.box_url = ENV['VAGRANT_BOX_URL'] || "https://opscode-vm.s3.amazonaws.com/vagrant/boxes/#{config.vm.box}.box"

  config.vm.provision :chef_solo do |chef|
    chef.data_bags_path = './data'
    chef.run_list = [ 
      'recipe[builder::default]'
    ]
  end
end

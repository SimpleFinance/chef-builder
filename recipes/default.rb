# recipes/default.rb
#
# Author: Simple Finance <ops@simple.com>
# License: Apache License, Version 2.0
#
# Copyright 2013 Simple Finance Technology Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Configures dependencies for a Builder

include_recipe 'runit::default'
include_recipe 'git::default'
include_recipe 'polyglot::default'

node[:builder][:helper_packages].each do |pkg|
  package pkg do
    action :install
  end
end

template ::File.join(node[:jenkins][:node][:home], '.ssh', 'known_hosts') do
  owner node[:jenkins][:node][:user]
  group node[:jenkins][:node][:group]
  mode 00644
  variables(
    :hashes => data_bag_item(:builder, :known_hosts)['hashes'] )
  action :create
end

file '/etc/cron.d/jenkins-workspace-tmpreap' do
  owner 'root'
  group 'root'
  content "*/10 * * * * root /usr/sbin/tmpreaper 24h #{node[:builder][:tmp_dir]} < /dev/null > /dev/null 2>&1\n"
end

directory node[:builder][:tmp_dir] do
  owner node[:jenkins][:node][:user]
  group node[:jenkins][:node][:user]
  recursive true
end

user node[:jenkins][:node][:user] do
  shell node[:jenkins][:node][:shell]
end


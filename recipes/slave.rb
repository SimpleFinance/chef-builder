# recipes/slave.rb
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
# Configures Jenkins build slaves

include_recipe "jenkins::node_#{node[:builder][:slave_strategy]}"
include_recipe 'builder::default'

svc = resources('runit_service[jenkins-slave]')
svc.cookbook 'builder'
svc.action [:enable]
svc.default_logger true
svc.env(node[:builder][:env])
svc.options({
  :envdir => "#{node[:runit][:sv_dir]}/jenkins-slave/env",
  :home => node[:jenkins][:node][:home],
  :user => node[:jenkins][:node][:user],
  :jnlp_url => "#{node[:jenkins][:server][:url]}/computer/#{node[:jenkins][:node][:name]}/slave-agent.jnlp" })


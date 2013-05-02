# recipes/master.rb
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
# Configures a Jenkins build master

node.override[:jenkins][:node][:mode] = 'exclusive'
node.override[:jenkins][:node][:executors] = 0

include_recipe 'nginx::default'
include_recipe 'jenkins::server'
include_recipe 'builder::default'

resources('runit_service[jenkins]').cookbook 'builder'

template ::File.join(node[:nginx][:dir], 'conf.d', 'jenkins.conf') do
  mode 00755
  variables(
    :server_name => node[:jenkins][:server][:host],
    :port => node[:jenkins][:server][:port] )
  action :create
  notifies :restart, 'service[nginx]', :immediately
end


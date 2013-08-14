# attributes/default.rb
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
# Attributes for Builder cookbook

normal[:jenkins][:node][:user] = 'jenkins'
normal[:jenkins][:node][:executors] = (2 * node[:cpu][:total])
normal[:jenkins][:node][:shell] = '/bin/bash'
normal[:jenkins][:node][:home] = '/mnt/jenkins'
normal[:polyglot][:user] = node[:jenkins][:node][:user]

permsize = (0.2 * (node[:memory][:total].sub("kB", "").to_i/1024)).to_i
normal[:jenkins][:server][:jvm_options] = "-XX:MaxPermSize=#{permsize}m"
normal[:jenkins][:server][:host] = 'localhost'
normal[:jenkins][:server][:home] = '/mnt/jenkins'
normal[:jenkins][:server][:url] = 'jenkins'
normal[:jenkins][:server][:port] = 8080
normal[:jenkins][:server][:group] = 'jenkins'
normal[:jenkins][:server][:plugins] = [ 'embeddable-build-status', 'tasks', 'analysis-core', 'checkstyle' ]
normal[:jenkins][:server][:data_dir] = ::File.join(node[:jenkins][:server][:home], 'jenkins-data')

# Builder environment / slave config
default[:builder][:helper_packages] = %w{ tmpreaper zip unzip }
default[:builder][:slave_strategy] = 'jnlp'
default[:builder][:encoding] = 'en_US.UTF-8'
default[:builder][:tmp_dir] = ::File.join(node[:jenkins][:node][:home], 'workspace-tmp')
default[:builder][:rack_env] = 'jenkins'
default[:builder][:data_bag_item] = 'known_hosts'
default[:builder][:env]["HOME"] = node[:jenkins][:node][:home]
default[:builder][:env]["LANG"] = node[:builder][:encoding]
default[:builder][:env]["LC_CTYPE"] = node[:builder][:encoding]
default[:builder][:env]["TMPDIR"] = node[:builder][:tmp_dir]
default[:builder][:env]["RACK_ENV"] = node[:builder][:rack_env]

default[:builder][:kernel][:packages] = [ 
  'fakeroot', 'build-essential', 'crash', 'kexec-tools', 'makedumpfile', 
  'kernel-wedge', 'git-core', 'libncurses5', 'libncurses5-dev', 'libelf-dev', 
  'asciidoc', 'binutils-dev' ]
default[:builder][:kernel][:build_dep_done] = '/var/.build_dep_done'


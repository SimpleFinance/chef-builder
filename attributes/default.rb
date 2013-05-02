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

override[:jenkins][:node][:user] = 'jenkins'
override[:jenkins][:node][:executors] = (2 * node[:cpu][:total])
override[:jenkins][:node][:shell] = '/bin/bash'
override[:jenkins][:node][:home] = '/mnt/jenkins'

permsize = (0.2 * (node[:memory][:total].sub("kB", "").to_i/1024)).to_i
override[:jenkins][:server][:jvm_options] = "-XX:MaxPermSize=#{permsize}m"
override[:jenkins][:server][:host] = 'localhost'
override[:jenkins][:server][:home] = '/mnt/jenkins'
override[:jenkins][:server][:port] = 8080
override[:jenkins][:server][:group] = 'jenkins'
override[:jenkins][:server][:url] = 'localhost'
override[:jenkins][:server][:plugins] = [ 'embeddable-build-status', 'tasks', 'analysis-core', 'checkstyle' ]
override[:jenkins][:server][:data_dir] = ::File.join(node[:jenkins][:server][:home], 'jenkins-data')

# Builder environment / slave config
default[:builder][:helper_packages] = %w{ tmpreaper zip unzip }
default[:builder][:slave_strategy] = 'jnlp'
default[:builder][:encoding] = 'en_US.UTF-8'
default[:builder][:tmp_dir] = ::File.join(node[:jenkins][:node][:home], 'workspace-tmp')
default[:builder][:rack_env] = 'jenkins'
default[:builder][:env] = {
  "HOME"         => node[:jenkins][:node][:home],
  "LANG"         => node[:builder][:encoding],
  "LC_CTYPE"     => node[:builder][:encoding],
  "TMPDIR"       => node[:builder][:tmp_dir],
  "RACK_ENV"     => node[:builder][:rack_env],
  "ANDROID_HOME" => node[:builder][:android][:home] }


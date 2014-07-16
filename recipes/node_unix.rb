#
# Cookbook Name:: rundeck
# Recipe:i: node_unix
#
# Copyright 2012, Peter Crossley
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


rundeck_secure = data_bag_item(node['rundeck']['rundeck_databag'], node['rundeck']['rundeck_databag_secure'])

if !node['rundeck']['secret_file'].nil? then
  rundeck_secret = Chef::EncryptedDataBagItem.load_secret(node['rundeck']['secret_file'])
  rundeck_secure = Chef::EncryptedDataBagItem.load(node['rundeck']['rundeck_databag'], node['rundeck']['rundeck_databag_secure'], rundeck_secret)
end  

user node['rundeck']['user'] do
  system true
  gid node['rundeck']['user']
  shell "/bin/bash"
  home node['rundeck']['basedir']
end

directory node['rundeck']['basedir'] do
  owner node['rundeck']['user']
  group node['rundeck']['user']
  recursive true
  mode 00700
end

directory "#{node['rundeck']['basedir']}/.ssh" do
  owner node['rundeck']['user']
  group node['rundeck']['user']
  recursive true
  mode 00700
end

file "#{node['rundeck']['basedir']}/.ssh/authorized_keys" do
  owner node['rundeck']['user']
  group node['rundeck']['user']
  mode 00600
  backup false
  content rundeck_secure['public_key']
end

sudo "rundeck-admin" do
 user node['rundeck']['user']
 nopasswd true
end

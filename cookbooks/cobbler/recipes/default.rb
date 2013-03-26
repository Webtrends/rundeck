#
# Cookbook Name:: cobbler
# Recipe:: default
#
# Copyright 2012, Webtrends Inc.
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

# install cobbler and dhcpd
%w{ cobbler cobbler-web isc-dhcp-server }.each do |pkg|
  package pkg
end

# disable apparmor so that dhcpd will start
# NOTE:  this issue has been resolved in Ubuntu 12.04
if node.platform_family?('debian') && node.platform_version.to_i < 12
  service "apparmor" do
    action :disable
    supports [ :restart, :reload, :status ]
  end
end

# setup the cobbler config
template "/etc/cobbler/settings" do
  source "settings.erb"
  mode 00644
  owner "root"
  group "root"
  variables(
    :server => node['ipaddress'],
    :next_server => node['ipaddress'],
    :manage_dhcp => node['cobbler']['manage_dhcp'],
    :pxe_just_once => node['cobbler']['pxe_just_once']
   )
  notifies :restart, "service[cobbler]"
end

# setup the dhcp template used by cobbler
template "/etc/cobbler/dhcp.template" do
  source "dhcp.template.erb"
  mode 00644
  owner "root"
  group "root"
  variables(
    :subnets => node['cobbler']['subnets']
  )
  notifies :run, "execute[cobbler sync]"
end

# fetch kickstarts and snippets
%w{ kickstarts snippets installer }.each do |dir|
  remote_directory "/var/lib/cobbler/#{dir}" do
    source dir
    files_owner "root"
    files_group "root"
    notifies :run, "execute[cobbler sync]"
  end
end

# template the centos_chef snippet to add the ntp server
template "/var/lib/cobbler/snippets/centos_chef" do
  source "centos_chef.erb"
  mode 00644
  owner "root"
  group "root"
end

# template centos_yum_repo
template '/var/lib/cobbler/snippets/centos_yum_repo' do
  source 'centos_yum_repo.erb'
  mode 00644
  owner 'root'
  group 'root'
  variables(
    :name        => node['cobbler']['yum']['name'],
    :description => node['cobbler']['yum']['description'],
    :baseurl     => node['cobbler']['yum']['baseurl']
  )
end

# fetch distros and profiles
%w{ config/distros.d config/profiles.d }.each do |dir|
  remote_directory "/var/lib/cobbler/#{dir}" do
    source dir
    files_owner "root"
    files_group "root"
    notifies :restart, "service[cobbler]"
  end
end

# template centos profiles
%w{ centos-6.2-x86_64 centos-6.4-x86_64 }.each do |profile|
  template "/var/lib/cobbler/config/profiles.d/#{profile}.json" do
    source "#{profile}.json.erb"
    mode 00644
    owner 'root'
    group 'root'
    variables(
      :tree => node['cobbler']['ks_meta']["#{profile}"]['tree']
    )
  end
end

# for local auth
template "/etc/cobbler/users.digest" do
  source "users.digest.erb"
  mode 00644
  owner "root"
  group "root"
  notifies :restart, "service[cobbler]"
end

# grab pxelinux.0
file "/var/lib/tftpboot/pxelinux.0" do
  content IO.read("/usr/lib/syslinux/pxelinux.0") rescue nil
end

# make validation.pem available
link "/var/www/validation.pem" do
  to Chef::Config[:validation_key]
end
file Chef::Config[:validation_key] do
	mode 00644
end

# firstboot script
cookbook_file '/var/www/firstbootrc.sh' do
  source 'firstbootrc.sh'
  owner 'root'
  group 'root'
  mode 00755
end

template '/var/www/firstboot.sh' do
  source 'firstboot.sh.erb'
  mode 00755
  owner 'root'
  group 'root'
  variables(
    :chef_versions => node['cobbler']['chef_version_ubuntu']
  )
end

execute "cobbler sync" do
  action :nothing
  command "/usr/bin/cobbler sync"
  ignore_failure true
end

service "cobbler" do
  action [:start, :enable]
  supports :status => true
end


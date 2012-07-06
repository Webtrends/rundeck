#
# Cookbook Name:: hbase
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

hadoop_namenode = search(:node, "role:hadoop_primarynamenode AND chef_environment:#{node.chef_environment}")
hadoop_namenode = hadoop_namenode.length == 1 ? hadoop_namenode.first[:fqdn] : "localhost"

hmaster = search(:node, "role:hadoop_primarynamenode AND chef_environment:#{node.chef_environment}")
hmaster = hmaster.length == 1 ? hmaster.first[:fqdn] : "localhost"

regionservers = Array.new
search(:node, "role:hadoop_datanode AND chef_environment:#{node.chef_environment}").each do |n|
  regionservers << n[:fqdn]
end

# hbase requires hadoop to be installed
include_recipe "hadoop"

# download hbase tar.gz
remote_file "#{node[:hadoop][:install_dir]}/hbase-#{node[:hbase][:version]}.tar.gz" do
  source "http://mirror.uoregon.edu/apache/hbase/hbase-#{node[:hbase][:version]}/hbase-#{node[:hbase][:version]}.tar.gz"
  owner "hadoop"
  group "hadoop"
  mode 00744
  not_if "test -f #{node[:hadoop][:install_dir]}/hbase-#{node[:hbase][:version]}.tar.gz"
end

# extract the tar.gz
execute "extract-hbase" do
  command "tar -zxf hbase-#{node[:hbase][:version]}.tar.gz"
  creates "hbase-#{node[:hbase][:version]}"
  cwd "#{node[:hadoop][:install_dir]}"
  user "hadoop"
  group "hadoop"
end

# link from the specific version of hbase to a generic path
link "/usr/local/hbase" do
  to "#{node[:hadoop][:install_dir]}/hbase-#{node[:hbase][:version]}"
end

# remove old hadoop core file, we run 0.20.205.0
file "/usr/local/hbase/lib/hadoop-core-0.20-append-r1056497.jar" do
  action :delete
end

# hbase needs right hadoop core
link "/usr/local/hbase/lib/hadoop-core-#{node[:hadoop][:version]}.jar" do
  to "/usr/share/hadoop/hadoop-core-#{node[:hadoop][:version]}.jar"
end

# create the log dir
directory "/var/log/hbase" do
	action :create
	owner "hadoop"
	group "hadoop"
	mode 00755
end

# manage hadoop configs
%w[masters regionservers hbase-env.sh hbase-site.xml log4j.properties].each do |template_file|
  template "/usr/local/hbase/conf/#{template_file}" do
    source "#{template_file}"
    mode 00755
    variables(
      :namenode => hadoop_namenode, # from hadoop recipe
      :hmaster => hmaster,
      :regionservers => regionservers
    )
  end
end
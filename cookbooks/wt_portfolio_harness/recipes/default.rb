#
# Cookbook Name:: wt_portfolio_harness
# Recipe:: default
#
# Copyright 2012, Webtrends
#
# All rights reserved - Do Not Redistribute
#

# include for the URI object
require 'uri'

# include runit so we can create a runit service
include_recipe "runit"

# install dependency packages
#%w{zeromq jzmq}.each do |pkg|
#  package pkg do
#    action :install
#  end
#end

# grab the zookeeper nodes that are currently available
zookeeper_quorum = Array.new
if not Chef::Config.solo
  search(:node, "role:zookeeper AND chef_environment:#{node.chef_environment}").each do |n|
    zookeeper_quorum << n['fqdn']
  end
end

if ENV["deploy_build"] == "true" then
  log "The deploy_build value is true so un-deploying first"
  include_recipe "wt_portfolio_harness::undeploy"
else
  log "The deploy_build value is not set or is false so we will only update the configuration"
end

log_dir     = File.join(node['wt_common']['log_dir_linux'], "harness")
install_dir = File.join(node['wt_common']['install_dir_linux'], "harness")
conf_url = File.join(install_dir, node['wt_portfolio_harness']['conf_url'])
tarball      = node['wt_portfolio_harness']['download_url'].split("/")[-1]
download_url = node['wt_portfolio_harness']['download_url']
java_home   = node['java']['java_home']
java_opts = node['wt_portfolio_harness']['java_opts']
user = node['wt_portfolio_harness']['user']
group = node['wt_portfolio_harness']['group']
pod = node['wt_realtime_hadoop']['pod']
datacenter = node['wt_realtime_hadoop']['datacenter']

# grab the users and passwords from the data bag
auth_data = data_bag_item('authorization', node.chef_environment)
usagedbuser  = auth_data['wt_streaming_usage_db']['db_user']
usagedbpwd = auth_data['wt_streaming_usage_db']['db_pwd']

log "Install dir: #{install_dir}"
log "Log dir: #{log_dir}"
log "Java home: #{java_home}"

# create the log directory
directory log_dir do
  owner   user
  group   group
  mode    00755
  recursive true
  action :create
end

# create the install directory
directory "#{install_dir}/bin" do
  owner "root"
  group "root"
  mode 00755
  recursive true
  action :create
end

directory "#{install_dir}/conf" do
  owner "root"
  group "root"
  mode 00755
  recursive true
  action :create
end

directory "#{install_dir}/modules" do
  owner "root"
  group "root"
  mode 00755
  recursive true
  action :create
end

def processTemplates (install_dir, conf_url, node, zookeeper_quorum, datacenter, pod, usagedbuser, usagedbpwd)
  log "Updating the template files"

    auth_url = node['wt_sauth']['auth_service_url']
    auth_uri = URI(auth_url)
    auth_host = auth_uri.host

    proxy_host = ''
    unless node['wt_common']['http_proxy_url'].nil? || node['wt_common']['http_proxy_url'].empty?
            proxy_uri = URI(node['wt_common']['http_proxy_url'])
            proxy_host = "#{proxy_uri.host}:#{proxy_uri.port}"
    end

  cam_url = node['wt_cam']['cam_service_url']
  port = node['wt_portfolio_harness']['port']

  usagedbserver = node['wt_streaming_usage_db']['db_server']
  usagedbname = node['wt_streaming_usage_db']['db_name']

  %w[log4j.xml config.properties netty.properties].each do | template_file|
    template "#{install_dir}/conf/#{template_file}" do
      source    "#{template_file}.erb"
      owner "root"
      group "root"
      mode  00644
      variables({
        :auth_url => auth_url,
        :auth_host => auth_host,
        :auth_version => node['wt_portfolio_harness']['sauth_version'],
        :proxy_host => proxy_host,
        :cam_url => cam_url,
        :install_dir => install_dir,
        :port => port,
        :wt_monitoring => node['wt_monitoring'],
        :router_uri => node['wt_portfolio_harness']['router_uri'],
        # usage db parameters
        :usagedbserver => usagedbserver,
        :usagedbname => usagedbname,
        :usagedbuser => usagedbuser,
        :usagedbpwd => usagedbpwd,

        # streaming 0mq parameters
        :zookeeper_quorum => zookeeper_quorum * ",",
        :pod              => pod,
        :datacenter       => datacenter,
      })
    end
  end
end

if ENV["deploy_build"] == "true" then
  log "The deploy_build value is true so we will grab the tar ball and install"

  # download the application tarball
  remote_file "#{Chef::Config[:file_cache_path]}/#{tarball}" do
    source download_url
    mode 00644
  end

  # uncompress the application tarball into the install dir
  execute "tar" do
    user  "root"
    group "root"
    cwd install_dir
    command "tar zxf #{Chef::Config[:file_cache_path]}/#{tarball}"
  end

  #templates
  template "#{install_dir}/bin/service-control" do
    source  "service-control.erb"
    owner "root"
    group "root"
    mode  00755
    variables({
      :log_dir => log_dir,
      :install_dir => install_dir,
      :conf_url => conf_url,
      :java_home => java_home,
      :java_jmx_port => node['wt_portfolio_harness']['jmx_port'],
      :java_opts => java_opts
    })
  end

  processTemplates(install_dir, conf_url, node, zookeeper_quorum, datacenter, pod, usagedbuser, usagedbpwd)

  # delete the install tar ball
  execute "delete_install_source" do
    user "root"
    group "root"
    command "rm -f #{Chef::Config[:file_cache_path]}/#{tarball}"
    action :run
  end

  # create the runit service
  runit_service "harness" do
    options({
      :log_dir => log_dir,
      :install_dir => install_dir,
      :java_home => java_home,
      :user => user
    })
  end

else
  processTemplates(install_dir, conf_url, node, zookeeper_quorum, datacenter, pod, usagedbuser, usagedbpwd)
end

if node.attribute?("nagios")
  #Create a nagios nrpe check for the healthcheck page
  nagios_nrpecheck "wt_healthcheck_page" do
    command "#{node['nagios']['plugin_dir']}/check_http"
    parameters "-H #{node['fqdn']} -u /healthcheck -p 9000 -r \"\\\"all_services\\\":\\s*\\\"ok\\\"\""
    action :add
  end
  #Create a nagios nrpe check for the log file
  nagios_nrpecheck "wt_garbage_collection_limit_reached" do
    command "#{node['nagios']['plugin_dir']}/check_log"
    parameters "-F /var/log/webtrends/harness/service.log -O /tmp/service_old.log -q 'GC overhead limit exceeded'"
    action :add
  end
end

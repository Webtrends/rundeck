#
# Cookbook Name:: wt_streamingconfigservice
# Recipe:: default
#
# Copyright 2012, Webtrends
#
# All rights reserved - Do Not Redistribute
#

# include runit so we can create a runit service
include_recipe "runit"

log "Deploy build is #{ENV["deploy_build"]}"
if ENV["deploy_build"] == "true" then
    log "The deploy_build value is true so un-deploy first"
    include_recipe "wt_streamingconfigservice::undeploy"
else
    log "The deploy_build value is not set or is false so we will only update the configuration"
end


log_dir      = File.join("#{node['wt_common']['log_dir_linux']}", "streamingconfigservice")
install_dir  = File.join("#{node['wt_common']['install_dir_linux']}", "streamingconfigservice")

# tarball      = "webtrends-streaming-configservice-bin.tar.gz"
java_home    = node['java']['java_home']
download_url = node['wt_streamingconfigservice']['download_url']
tarball      = node['wt_streamingconfigservice']['download_url'].split("/")[-1]
user = node['wt_streamingconfigservice']['user']
group = node['wt_streamingconfigservice']['group']
java_opts = node['wt_streamingconfigservice']['java_opts']

log "Install dir: #{install_dir}"
log "Log dir: #{log_dir}"
log "Java home: #{java_home}"

# create the log directory
directory "#{log_dir}" do
	owner   user
	group   group
	mode    00755
	recursive true
	action :create
end

# create the bin directory
directory "#{install_dir}/bin" do
	owner "root"
	group "root"
	mode 00755
	recursive true
	action :create
end

# create the conf directory
directory "#{install_dir}/conf" do
	owner "root"
	group "root"
	mode 00755
	recursive true
	action :create
end

def processTemplates (install_dir, node, user, group)
	log "Updating the template files"

    # grab the users and passwords from the data bag
    auth_data = data_bag_item('authorization', node.chef_environment)
    camdbuser  = auth_data['wt_streamingconfigservice']['camdbuser']
    camdbpwd = auth_data['wt_streamingconfigservice']['camdbpwd']
    masterdbuser = auth_data['wt_streamingconfigservice']['masterdbuser']
    masterdbpwd = auth_data['wt_streamingconfigservice']['masterdbpwd']

    %w[monitoring.properties config.properties].each do |template_file|
      template "#{install_dir}/conf/#{template_file}" do
	        source	"#{template_file}.erb"
	        owner user
	        group group
	        mode  00755
	        variables({
                    :port => node['wt_streamingconfigservice']['port'],
                    :camdbserver => node['wt_streamingconfigservice']['camdbserver'],
                    :camdbname => node['wt_streamingconfigservice']['camdbname'],
                    :camdbuser => camdbuser,
                    :camdbpwd => camdbpwd,
                    :masterdbserver => node['wt_streamingconfigservice']['masterdbserver'],
                    :masterdbname => node['wt_streamingconfigservice']['masterdbname'],
                    :masterdbuser => masterdbuser,
                    :masterdbpwd => masterdbpwd,
                    :includeUnmappedAnalyticsIds => node['wt_streamingconfigservice']['includeUnmappedAnalyticsIds'],
                    :wt_monitoring => node[:wt_monitoring]
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

    # uncompress the application tarball into the install directory
    execute "tar" do
			user  "root"
			group "root"
			cwd install_dir
			command "tar zxf #{Chef::Config[:file_cache_path]}/#{tarball}"
    end

    template "#{install_dir}/bin/service-control" do
        source  "service-control.erb"
        owner "root"
        group "root"
        mode  00755
        variables({
            :log_dir => log_dir,
            :install_dir => install_dir,
            :java_home => java_home,
            :user => user,
            :java_class => "com.webtrends.streaming.configservice.ConfigServiceDaemon",
            :java_jmx_port => node['wt_monitoring']['jmx_port'],
            :java_opts => java_opts
        })
    end

    processTemplates(install_dir, node, user, group)

    # delete the application tarball
    execute "delete_install_source" do
        user "root"
        group "root"
        command "rm -f #{Chef::Config[:file_cache_path]}/#{tarball}"
        action :run
    end

    # create a runit service
    runit_service "streamingconfigservice" do
    options({
        :log_dir => log_dir,
        :install_dir => install_dir,
        :java_home => java_home,
        :user => user
    })
    end
else
    processTemplates(install_dir, node, user, group)
end

#Create collectd plugin for streamingconfigservice JMX objects if collectd has been applied.
if node.attribute?("collectd")
  template "#{node[:collectd][:plugin_conf_dir]}/collectd_streamingconfigservice.conf" do
    source "collectd_streamingconfigservice.conf.erb"
    owner "root"
    group "root"
    mode 00644
    notifies :restart, resources(:service => "collectd")
  end
end

if node.attribute?("nagios")

  #Create a nagios nrpe check for the healthcheck page
	nagios_nrpecheck "wt_healthcheck_page" do
		command "#{node['nagios']['plugin_dir']}/check_http"
		parameters "-H #{node[:fqdn]} -u /healthcheck -p 9000 -r \"\\\"all_services\\\": \\\"ok\\\"\""
		action :add
	end

end
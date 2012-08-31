#
# Cookbook Name:: wt_cam
# Recipe:: cam_auth
# Author: Ivan von Nagy(<ivan.vonnagy@webtrends.com>)
#
# Copyright 2012, Webtrends
#
# All rights reserved - Do Not Redistribute
# This recipe installs the plugins into the CAM site

#Properties
pod = node.chef_environment
user_data = data_bag_item('authorization', pod)
plugin_install_dir = "#{node['wt_common']['install_dir_windows']}\\Webtrends.Cam\\Plugins"

# Make sure the plugin directory exists
directory plugin_install_dir do
	recursive true
	action :create
end

# Make sure the security is correct
wt_base_icacls plugin_install_dir do
	action :grant
	user user_data['wt_common']['ui_user']
	perm :modify
end

if deploy_mode?

    # Lay the files down
    windows_zipfile plugin_install_dir do
        source node['wt_cam']['cam_plugins']['download_url']
        action :unzip
    end

    # Restart the CAM site
    iis_site 'CAM' do
        action [:restart]
    end
end
#
# Cookbook Name:: wt_static_tag_host
# Recipe:: default
#
# Copyright 2012, Webtrends
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

# disable the default apache site
apache_site "000-default" do
  enable false
end

if ENV["deploy_build"] != "true" then
    log "The deploy_build value is not set or is false so exit here"
else
    log "The deploy_build value is true so we will deploy"
    include_recipe "wt_static_tag_host::undeploy"

	# template the apache config for the repo site
	template "#{node['apache']['dir']}/sites-available/static_tag_host.conf" do
		source "apache2.conf.erb"
		mode 00644
		variables(:docroot => "/var/www")
	end

    #Enable the apache site
    apache_site "static_tag_host.conf" do
      enable true
    end

end

#Create a .htaccess file in /var/www to redirect people to www.webtrends.com in the absence of a index.html file
cookbook_file "/var/www/.htaccess" do
  source "htaccess"
  mode 0644
  owner "root"
  group "root"
end

#Create collectd plugin for apache if collectd has been applied.
if node.attribute?("collectd")
  template "#{node['collectd']['plugin_conf_dir']}/collectd_apache2_static-tag.conf" do
    source "collectd_apache2_static-tag.conf.erb"
    owner "root"
    group "root"
    mode 00644
    notifies :restart, resources(:service => "collectd")
  end
end
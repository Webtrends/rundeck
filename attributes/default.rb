default['rundeck'] = {}
default['rundeck']['configdir'] = "/etc/rundeck"
default['rundeck']['basedir'] = "/var/lib/rundeck"
default['rundeck']['datadir'] = "/var/rundeck"
default['rundeck']['deb'] = "rundeck-2.1.0-1-GA.deb"
default['rundeck']['version'] = '2.2.1-1.23.GA'
default['rundeck']['url'] = "http://download.rundeck.org/deb/#{node['rundeck']['deb']}"
default['rundeck']['checksum'] = "a94173728158c0f6488d80a40f9b5b0ac16bada38c737c87c58e6c59f15015a7"
default['rundeck']['port'] = 4440
default['rundeck']['chef_rundeck_gem'] = nil
default['rundeck']['chef_rundeck_port'] = 9980
default['rundeck']['chef_rundeck_host'] = "0.0.0.0"
default['rundeck']['chef_rundeck_partial_search'] = false
default['rundeck']['user'] = "rundeck"
default['rundeck']['user_home'] = "/home/rundeck"
default['rundeck']['chef_config'] = "/etc/chef/rundeck.rb"
default['rundeck']['chef_rundeck_url'] = "http://chef.#{node['domain']}:#{node['rundeck']['chef_rundeck_port']}"
default['rundeck']['chef_webui_url'] = "https://chef.#{node['domain']}"
default['rundeck']['chef_url'] = "https://chef.#{node['domain']}"
default['rundeck']['project_config'] = "/etc/chef/chef-rundeck.json"
default['rundeck']['jaas'] = "internal"
default['rundeck']['default_role'] = "user"
default['rundeck']['hostname'] = "rundeck.#{node['domain']}"
default['rundeck']['email'] = "rundeck@#{node['domain']}"
default['rundeck']['restart_on_config_change'] = false
default['rundeck']['apache-template']['cookbook'] = "rundeck"

# SMTP settings for rundeck notification emails
default['rundeck']['mail']['enable'] = false
default['rundeck']['mail']['host'] = "localhost"
default['rundeck']['mail']['port'] = "25"
default['rundeck']['mail']['username'] = ""
default['rundeck']['mail']['password'] = ""

#   If you want to use encrypted databags for your windows password and/or public/private key pairs generate a secret using:
#     'openssl rand -base64 512 | tr -d '\r\n' > rundeck_secret'
#   Distrubute to all sytems that will work with rundeck via a recipe and set the path to that file in the following attribute
#
default['rundeck']['secret_file'] = nil

# External Database properties
default['rundeck']['rdbms']['enable'] = "false"
default['rundeck']['rdbms']['type'] = "mysql"
default['rundeck']['rdbms']['location'] = "someIPorFQDN"
default['rundeck']['rdbms']['dbname'] = "rundeckdb"
default['rundeck']['rdbms']['dbuser'] = "rundeckdb"
default['rundeck']['rdbms']['dbpassword'] = "Chang3ME"
default['rundeck']['rdbms']['dialect'] = "Oracle10gDialect"
default['rundeck']['rdbms']['port'] = "3306"

# Windows Properties
default['rundeck']['windows']['group'] = 'Administrators'
default['rundeck']['windows']['user'] = node['rundeck']['user']
default['rundeck']['windows']['password'] = nil
default['rundeck']['windows']['winrm_auth_type'] = 'basic'
default['rundeck']['windows']['winrm_cert_trust'] = 'all'
default['rundeck']['windows']['winrm_hostname_trust'] = 'all'
default['rundeck']['windows']['winrm_protocol'] = 'https'

# LDAP Properties
default['rundeck']['ldap']['provider'] = "ldap://servername:389"
default['rundeck']['ldap']['binddn'] = "CN=binddn,dc=domain,dc=com"
default['rundeck']['ldap']['bindpwd'] = "BINDPWD"
default['rundeck']['ldap']['userbasedn'] = "ou=Users,dc=domain,dc=com"
default['rundeck']['ldap']['rolebasedn'] = "ou=Groups,dc=domain,dc=com"

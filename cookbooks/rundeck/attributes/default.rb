default['rundeck'] = {}
default['rundeck']['configdir'] = "/etc/rundeck"
default['rundeck']['basedir'] = "/var/rundeck"
default['rundeck']['user'] = "rundeck"
default['rundeck']['user_home'] = "/home/rundeck"
default['rundeck']['chef_config'] = "/etc/chef/rundeck.rb"
default['rundeck']['chef_rundeck_url'] = "http://chef.#{node['domain']}:9980"
default['rundeck']['chef_webui_url'] = "http://chef.#{node['domain']}:4040"
default['rundeck']['chef_url'] = "http://chef.#{node['domain']}:4000"
default['rundeck']['project_config'] = "/etc/chef/chef-rundeck.json"

default['rundeck']['jaas'] = "internal"

# External Database properties
default['rundeck']['rdbms']['enable'] = "false"
default['rundeck']['rdbms']['type'] = "mysql"
default['rundeck']['rdbms']['location'] = "someIPorFQDN"
default['rundeck']['rdbms']['dbname'] = "rundeckdb"
default['rundeck']['rdbms']['dbuser'] = "rundeckdb"
default['rundeck']['rdbms']['dbpassword'] = "Chang3ME"
default['rundeck']['rdbms']['dialect'] = "Oracle10gDialect"
default['rundeck']['rdbms']['port'] = "3306"

#LDAP Properties
default['rundeck']['ldap']['provider'] = "ldap://seadc01.webtrends.corp:389 ldap://seadc02.webtrends.corp:389"
default['rundeck']['ldap']['binddn'] = "CN=winbind,ou=serviceaccountsOLD,ou=WebTrendsUsers,dc=webtrends,dc=corp"
default['rundeck']['ldap']['bindpwd'] = "P1eas3Jo1nM3"
default['rundeck']['ldap']['userbasedn'] = "ou=WebTrendsUsers,dc=webtrends,dc=corp"
default['rundeck']['ldap']['rolebasedn'] = "ou=Security,ou=Groups,dc=webtrends,dc=corp"

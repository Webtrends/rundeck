installdir = node['webtrends']['installdir']
archive_url = node['webtrends']['archive_server']
install_url = node['webtrends']['install_server']

v1_install_url = node['webtrends']['dx']['v1_url']
v1_installdir = node['webtrends']['dx']['v1_1']['dir']

v2_install_url = node['webtrends']['dx']['v2_url']
v2_installdir = node['webtrends']['dx']['v2']['dir']


v21_install_url = node['webtrends']['dx']['v2_1_url']
v21_installdir = node['webtrends']['dx']['v2_1']['dir']

v22_install_url = node['webtrends']['dx']['v2_2_url']
v22_installdir = node['webtrends']['dx']['v2_2']['dir']

v3_install_url = node['webtrends']['dx']['v3_url']
v3_installdir = node['webtrends']['dx']['v3']['dir']

windows_zipfile "#{installdir}#{v1_installdir}" do
  source "#{archive_url}#{v1_install_url}"
  action :unzip	
  not_if {::File.exists?("#{installdir}#{v1_installdir}\\web.config")}
end


windows_zipfile "#{installdir}#{v2_installdir}" do
  source "#{archive_url}#{v2_install_url}"
  action :unzip	
  not_if {::File.exists?("#{installdir}#{v21_installdir}\\web.config")}
end

windows_zipfile "#{installdir}#{v21_installdir}" do
  source "#{archive_url}#{v21_install_url}"
  action :unzip	
  not_if {::File.exists?("#{installdir}#{v21_installdir}\\web.config")}
end

windows_zipfile "#{installdir}#{v22_installdir}" do
  source "#{archive_url}#{v22_install_url}"
  action :unzip	
  not_if {::File.exists?("#{installdir}#{v22_installdir}\\web.config")}
end

windows_zipfile "#{installdir}#{v3_installdir}" do
  source "#{install_url}#{v3_install_url}"
  action :unzip	
  not_if {::File.exists?("#{installdir}#{v3_installdir}\\StreamingServices\\log4net.config")}
end

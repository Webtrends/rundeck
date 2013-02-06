#
# Cookbook Name:: wt_streamingapi
# Attributes:: default
#
# Copyright 2012, Webtrends
#
# All rights reserved - Do Not Redistribute
#

default['wt_streamingapi']['user']                      = "webtrends"
default['wt_streamingapi']['group']                     = "webtrends"
default['wt_streamingapi']['download_url']              = ""
default['wt_streamingapi']['port']                      = 8080
default['wt_streamingapi']['java_opts']                 = "-Xms2048m -XX:+UseG1GC -Djava.net.preferIPv4Stack=true"
default['wt_streamingapi']['jar']                       = "webtrends-streamingapi.jar"
default['wt_streamingapi']['jmx_port']                  = 9999
default['wt_streamingapi']['graphite_enabled'] = "true"
default['wt_streamingapi']['graphite_interval'] = 5
default['wt_streamingapi']['graphite_vmmetrics'] = "true"
default['wt_streamingapi']['graphite_regex'] = ""
default['wt_streamingapi']['writeBufferHighWaterMark'] = 1048576
default['wt_streamingapi']['log_dir'] = "/var/log/webtrends/streamingapi"
default['wt_streamingapi']['proxy_host']               = ""
default['wt_streamingapi']['sauth_version'] = "v1"
default['wt_streamingapi']['explore_timeout'] = 10
default['wt_streamingapi']['explore_quietperiod'] = 0

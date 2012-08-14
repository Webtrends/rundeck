#
# Author:: Sean McNamara (<sean.mcnamara@webtrends.com>)
# Cookbook Name:: wt_storm_streaming
# Attribute:: default
#
# Copyright 2012, Webtrends Inc.
#

default['wt_storm_streaming']['cluster_role'] = "wt_storm_realtime_streaing"

# general storm attributes
default['wt_storm_streaming']['java_lib_path'] = "/usr/local/lib:/opt/local/lib:/usr/lib"
default['wt_storm_streaming']['local_dir'] = "/mnt/storm"
default['wt_storm_streaming']['local_mode_zmq'] = "false"
default['wt_storm_streaming']['cluster_mode'] = "distributed"


# zookeeper attributes
default['wt_storm_streaming']['zookeeper']['port'] = 2181
default['wt_storm_streaming']['zookeeper']['root'] = "/v2-storm-streaming"
default['wt_storm_streaming']['zookeeper']['session_timeout'] = 20000
default['wt_storm_streaming']['zookeeper']['retry_times'] = 5
default['wt_storm_streaming']['zookeeper']['retry_interval'] = 1000


# supervisor attributes
default['wt_storm_streaming']['supervisor']['workers'] = 4
default['wt_storm_streaming']['supervisor']['childopts'] = "-Xmx1024m"
default['wt_storm_streaming']['supervisor']['worker_start_timeout'] = 120
default['wt_storm_streaming']['supervisor']['worker_timeout_secs'] = 30
default['wt_storm_streaming']['supervisor']['monitor_frequecy_secs'] = 3
default['wt_storm_streaming']['supervisor']['heartbeat_frequency_secs'] = 5
default['wt_storm_streaming']['supervisor']['enable'] = true


# worker attributes
default['wt_storm_streaming']['worker']['childopts'] = "-Xmx768m -XX:+UseConcMarkSweepGC -Dcom.sun.management.jmxremote"
default['wt_storm_streaming']['worker']['heartbeat_frequency_secs'] = 1
default['wt_storm_streaming']['task']['heartbeat_frequency_secs'] = 3
default['wt_storm_streaming']['task']['refresh_poll_secs'] = 10
default['wt_storm_streaming']['zmq']['threads'] = 1
default['wt_storm_streaming']['zmq']['longer_millis'] = 5000


# nimbus attributes
default['wt_storm_streaming']['nimbus']['host'] = ""
default['wt_storm_streaming']['nimbus']['thrift_port'] = 6627
default['wt_storm_streaming']['nimbus']['childopts'] = "-Xmx1024m"
default['wt_storm_streaming']['nimbus']['task_timeout_secs'] = 30
default['wt_storm_streaming']['nimbus']['supervisor_timeout_secs'] = 60
default['wt_storm_streaming']['nimbus']['monitor_freq_secs'] = 10
default['wt_storm_streaming']['nimbus']['cleanup_inbox_freq_secs'] = 600
default['wt_storm_streaming']['nimbus']['inbox_jar_expiration_secs'] = 3600
default['wt_storm_streaming']['nimbus']['task_launch_secs'] = 120
default['wt_storm_streaming']['nimbus']['reassign'] = true
default['wt_storm_streaming']['nimbus']['file_copy_expiration_secs'] = 600


# ui attributes
default['wt_storm_streaming']['ui']['port'] = 8080
default['wt_storm_streaming']['ui']['childopts'] = "-Xmx768m"


# drpc attributes
default['wt_storm_streaming']['drpc']['port'] = 3772
default['wt_storm_streaming']['drpc']['invocations_port'] = 3773
default['wt_storm_streaming']['drpc']['request_timeout_secs'] = 600


# transactional attributes
default['wt_storm_streaming']['transactional']['zookeeper']['root'] = "/v2-storm-streaming-transactional"
default['wt_storm_streaming']['transactional']['zookeeper']['port'] = 2181


# topology attributes
default['wt_storm_streaming']['topology']['debug'] = false
default['wt_storm_streaming']['topology']['optimize'] = true
default['wt_storm_streaming']['topology']['workers'] = 1
default['wt_storm_streaming']['topology']['acker_executors'] = 1
default['wt_storm_streaming']['topology']['acker_tasks'] = "null"
default['wt_storm_streaming']['topology']['tasks'] = "null"
default['wt_storm_streaming']['topology']['message_timeout_secs'] = 30
default['wt_storm_streaming']['topology']['skip_missing_kryo_registrations'] = false
default['wt_storm_streaming']['topology']['max_task_parallelism'] = "null"
default['wt_storm_streaming']['topology']['max_spout_pending'] = "null"
default['wt_storm_streaming']['topology']['state_synchronization_timeout_secs'] = 60
default['wt_storm_streaming']['topology']['stats_sample_rate'] = 0.05
default['wt_storm_streaming']['topology']['fall_back_on_java_serialization'] = true
default['wt_storm_streaming']['topology']['worker_childopts'] = "null"


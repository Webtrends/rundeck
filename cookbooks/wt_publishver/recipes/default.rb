#
# Cookbook Name:: wt_publishver
# Recipe:: default
#
# Copyright 2012, Webtrends Inc.
#
# All rights reserved - Do Not Redistribute
#

# centos is untested
if node['platform_family'] == 'rhel'
	log("#{cookbook_name}: unsupported platform: #{node['platform_family']} #{node['platform_version']}") { level :warn }
	return
end

# no support for ubuntu less than precise
if node['platform'] == 'ubuntu' and node['platform_version'].to_i < 12
	log("#{cookbook_name}: unsupported platform: #{node['platform']} #{node['platform_version']}") { level :warn }
	return
end

# abort if gcc or make missing (needed for nokogiri build)
%w{ gcc make }.each do |cmd|
	if not system("which #{cmd} > /dev/null")
		log("#{cookbook_name}: #{cmd} is missing") { level :warn }
		return
	end
end

class Chef::Resource
	# returns a path with backslashes (windows friendly)
	def win_path(*args)
		::File.join(args).gsub(/[\\\/]+/, '\\')
	end
end

#
# install prerequisites
#
wt_publishver 'Install Prerequisites' do
	action :deploy_prereqs
end

# linux install directory
ldir = node['wt_common']['install_dir_linux']


# windows install directory
wdir = node['wt_common']['install_dir_windows']

node['roles'].each do |r|
	case r
	when 'wt_actioncenter'
		log "publishing #{r}"
		wt_publishver 'Action Center' do
			download_url node['wt_actioncenter']['download_url']
			key_file     win_path(wdir, 'Webtrends.ActionCenter/Webtrends.ActionCenterService/bin/Webtrends.ActionCenter.dll')
		end
	when 'wt_analytics_ui'
		log "publishing #{r}"
		wt_publishver 'A10 UI' do
			download_url node['wt_analytics_ui']['download_url']
			key_file     win_path(wdir, node['wt_analytics_ui']['install_dir'], 'bin/WebTrends.UI.Reporting.dll')
		end
	when 'wt_cam'
		log "publishing #{r}"
		wt_publishver 'CAM' do
			download_url node['wt_cam']['download_url']
			key_file     win_path(wdir, 'Webtrends.Cam/bin/Webtrends.Cam.dll')
		end
	when 'wt_data_deleter'
		log "publishing #{r}"
		wt_publishver 'Data Deleter' do
			download_url node['wt_data_deleter']['download_url']
			key_file     win_path(wdir, node['wt_data_deleter']['install_dir'], 'DataDeleter.exe')
		end
	when 'wt_devicedataupdater'
		log "publishing #{r}"
		wt_publishver 'Device Data Updater' do
			download_url node['wt_devicedataupdater']['download_url']
			key_file     win_path(wdir, node['wt_devicedataupdater']['install_dir'], 'DDU.exe')
		end
	when 'wt_edge_server'
		log "publishing #{r}"
		wt_publishver 'Edge Server' do
			download_url node['wt_edge_server']['download_url']
			key_file     File.join(ldir, 'edge_server/lib/webtrends-edge-server-module-rcs.jar')
		end
	when 'wt_hdfslogdata_producer'
		log "publishing #{r}"
		wt_publishver 'HDFS Log Data Producer' do
			download_url node['wt_hdfslogdata_producer']['download_url']
			key_file     File.join(ldir, 'hdfslogdata_producer/lib/webtrends-visitoranalytics-hdfslogproducer-*')
		end
	when 'wt_kafka_topagg'
		log "publishing #{r}"
		wt_publishver 'Kafka Top Aggregator' do
			download_url node['wt_kafka_topagg']['download_url']
			key_file     File.join(ldir, node['wt_kafka_topagg']['name'], 'lib/TopicAggregator.jar')
		end
	when 'wt_logpreproc'
		log "publishing #{r}"
		wt_publishver 'LPP' do
			download_url node['wt_logpreproc']['download_url']
			key_file     win_path(wdir, node['wt_logpreproc']['install_dir'], 'wtlogpreproc.exe')
		end
	when 'wt_platformscheduler_agent'
		log "publishing #{r}"
		wt_publishver 'Platform Scheduler Agent' do
			download_url node['wt_platformscheduler']['agent']['download_url']
			key_file     win_path(wdir, 'common/agent/Webtrends.Agent.exe')
		end
	when 'wt_portfolio_admin'
		log "publishing #{r}"
		wt_publishver 'Portfolio Admin' do
			download_url node['wt_portfolio_admin']['download_url']
			key_file     win_path(wdir, 'Webtrends.Portfolio.Admin/bin/Webtrends.Portfolio.Admin.dll')
		end
	when 'wt_portfolio_edgeservice'
		log "publishing #{r}"
		wt_publishver 'Portfolio Edge Service' do
			download_url node['wt_portfolio_edgeservice']['download_url']
			key_file     File.join(ldir, 'edgeservice/lib/webtrends-portfolio-edge-service-*')
		end
	when 'wt_portfolio_edge_stream_api'
		log "publishing #{r}"
		wt_publishver 'Portfolio Edge API' do
			download_url node['wt_portfolio_edge_stream_api']['download_url']
			key_file     File.join(ldir, 'edgeservice/modules/stream_api/webtrends-stream-edge-api-*')
		end
	when 'wt_portfolio_manager'
		log "publishing #{r}"
		wt_publishver 'Portfolio Manager' do
			download_url node['wt_portfolio_manager']['download_url']
			key_file     win_path(wdir, 'Webtrends.Portfolio.Manager/bin/Webtrends.PortfolioManager.dll')
		end
	when 'wt_portfolio_router'
		log "publishing #{r}"
		wt_publishver 'Portfolio Router' do
			download_url node['wt_portfolio_router']['download_url']
			key_file     File.join(ldir, 'router/lib/webtrends-portfolio-router-*')
		end
	when 'wt_roadrunner'
		log "publishing #{r}"
		wt_publishver 'RoadRunner Service' do
			download_url node['wt_roadrunner']['download_url']
			key_file     win_path(wdir, node['wt_roadrunner']['install_dir'], 'Webtrends.RoadRunner.Service.exe')
		end
	when 'wt_sauth'
		log "publishing #{r}"
		wt_publishver 'Streaming Auth' do
			download_url node['wt_sauth']['download_url']
			key_file     win_path(wdir, 'Webtrends.Auth/bin/Webtrends.Auth.dll')
		end
	when 'wt_search'
		log "publishing #{r}"
		wt_publishver 'Search Service' do
			download_url node['wt_search']['download_url']
			key_file     win_path(wdir, node['wt_search']['install_dir'], 'Webtrends.Search.Service.exe')
		end
	when 'wt_storm_streaming_topo'
		log "publishing #{r}"
		wt_publishver 'Streaming Storm Topology' do
			download_url node['wt_storm_streaming']['download_url']
			key_file     File.join(node['storm']['install_dir'], "storm-#{node['storm']['version']}", 'lib/webtrends-core-*')
		end
	when 'wt_streaminganalysis_monitor'
		log "publishing #{r}"
		wt_publishver 'Streaming Analysis Monitor' do
			download_url node['wt_streaminganalysis_monitor']['download_url']
			key_file     File.join(ldir, 'streaminganalysis_monitor/lib/webtrends-streaming-analysis-monitor.jar')
		end
	when 'wt_streaming_api_server'
		log "publishing #{r}"
		wt_publishver 'Streaming API' do
			download_url node['wt_streamingapi']['download_url']
			key_file     File.join(ldir, 'streamingapi/lib/webtrends-streamingapi.jar')
		end
	when 'wt_streaming_auditor'
		log "publishing #{r}"
		wt_publishver 'Streaming Auditor' do
			download_url node['wt_streamingauditor']['download_url']
			key_file     File.join(ldir, 'streamingauditor/lib/webtrends-auditing-*')  
		end
	when 'wt_streaming_collection_server'
		log "publishing #{r}"
		wt_publishver 'Streaming Collection' do
			download_url node['wt_streamingcollection']['download_url']
			key_file     File.join(ldir, 'streamingcollection/lib/webtrends-streamingcollection.jar')
		end
	when 'wt_streaming_configservice'
		log "publishing #{r}"
		wt_publishver 'Streaming Config Service' do
			download_url node['wt_streamingconfigservice']['download_url']
			key_file     File.join(ldir, 'streamingconfigservice/lib/webtrends-streaming-configservice.jar')
		end
	when 'wt_streaming_logreplayer'
		log "publishing #{r}"
		wt_publishver 'Log Replayer' do
			download_url node['wt_streaminglogreplayer']['download_url']
			key_file     File.join(ldir, 'streaminglogreplayer/lib/webtrends-streaminglogreplayer.jar')
		end
	when 'wt_streaming_managementservice'
		log "publishing #{r}"
		wt_publishver 'Streaming Management Service' do
			download_url node['wt_streamingmanagementservice']['download_url']
			key_file     File.join(ldir, 'streamingmanagementservice/lib/webtrends-streaming-managementservice.jar')
		end
	when 'wt_stream_processor'
		log "publishing #{r}"
		wt_publishver 'Streaming Processor' do
			download_url node['wt_stream_processor']['download_url']
			key_file     File.join(ldir, 'streamprocessor/lib/webtrends-stream-processor-*')
		end
	when 'wt_streaming_viz'
		log "publishing #{r}"
		wt_publishver 'Streaming Viz' do
			download_url node['wt_streaming_viz']['download_url']
			key_file     win_path(wdir, 'Webtrends.Streaming.Viz/bin/Webtrends.Streaming.Viz.dll')
		end
	when 'wt_sync'
		log "publishing #{r}"
		wt_publishver 'Sync Service' do
			download_url node['wt_sync']['download_url']
			key_file     win_path(wdir, node['wt_sync']['install_dir'], 'Webtrends.SyncService.exe')
		end
	when 'wt_thumbnail_capture'
		log "publishing #{r}"
		wt_publishver 'Thumbnail Capture' do
			download_url node['wt_thumbnailcapture']['download_url']
			key_file     File.join(ldir, 'thumbnailcapture/capture-service-*')
		end
	when 'wt_xd_importer'
		log "publishing #{r}"
		wt_publishver 'External Data Importer' do
			download_url node['wt_xd_importer']['download_url']
			key_file     win_path(wdir, node['wt_xd_importer']['install_dir'], 'Webtrends.ExternalData.Refresh.exe')
		end
	when 'wt_xd_mapreduce'
		log "publishing #{r}"
		wt_publishver 'External Data Mapreduce' do
			download_url node['wt_xd']['download_url']
			key_file     File.join(ldir, 'wt_xd/lib/webtrends.mapreduce.common.jar')
		end
	else
		log "no publishing data for role => #{r}"
	end
end

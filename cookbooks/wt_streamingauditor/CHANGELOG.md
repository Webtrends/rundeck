## 0.0.19
* Created an attribute for the root logging level for log4j

## 0.0.18
* Removed the force-stop from undeploy.rb

## 0.0.15
* Added logic to use the wt_monitoring client id and secret to get a token to connect to SAPI

## 0.0.16
* Use JMX port from cookbook attribute not from wt_monitoring attribute
* Don't fallback to attributes if the Zookeeper search fails
* Fix non-standard JMX ports breaking Graphite logging of JMX values
* Remove unused "user" variable from service control template
* Address food critic warnings
* Remove hard coded java_class variable from the service control template

## 0.0.15
* Don't fall back to a valid TC URL

## 0.0.14
* Removed old undelpoy code

## 0.0.13
* Moved 'datacenter' and 'pod' in kafka.properties.erb directly into 'sapi.znode.root' to simplify the code

## 0.0.12
* Added metrics listener support

## 0.0.11
* Added broker chroot prefix for zk.connect string

## 0.0.10
* Fixed escaping issue with Nagios entry

## 0.0.9
* Fixed Nagios regex issue
* Changed default tar file to prepend 'webtrends-'

## 0.0.8
* Added roundtrip_tagserver_timeout to wait for receiving an event back before erroring out.
* Added roundtrip_scs_timeout to wait for receiving an event back before erroring out.

## 0.0.7
* Added roundtrip support and renamed cookobook to wt_streamingauditor
* Added unploy_old recipe until the old service has gone through an install cycle on each of the environments. At that time the undeploy_old can be deleted.

## 0.0.6
* Externalized the healthcheck options 'healthcheck_enabled' to [:wt_monitoring][:healthcheck_enabled]
* Externalized the healthcheck options 'healthcheck_port' to [:wt_monitoring][:healthcheck_port]

## 0.0.5
* Added gate keeper for deploy using the deploy_build environment variable

## 0.0.4
* Removed 'tarball' attribute as it is included in the download_url
* Externalized the java options 'java_opts'
* Externalized the java options 'jmx_port' to [:wt_monitoring][:jmx_port]

## 0.0.3
* Moved monitoring attributes to wt_monitoring

## 0.0.2:
* Searches for zookeeper were made using nodes that apply the zookeeper recipe. In our environment we
* apply a zookeeper role instead tso the search was changed to look for the role

## 0.0.1:
* Initial release with a changelog
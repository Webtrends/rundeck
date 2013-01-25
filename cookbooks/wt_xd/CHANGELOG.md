## 2.0.14
* hotfix required to remove hbase row level locking to keep track of high water mark of processing

## 2.0.13
* Removing reference to Webtrends.ExternalData.StorageService.log4net.config from importer.rb

## 2.0.12
* Adding XD refresh utility registration with scheduler agent

## 2.0.11
* Fixing services installation issues

## 2.0.10
* Fixing importer.rb

## 2.0.9
* Updated config files

## 2.0.8
* Removed dll config files
* Added sftpPush plugin

## 2.0.7
* Added uninstall calls to binaries

## 2.0.6
* Added rsa key support

## 2.0.5
* Renamed default to importer, and added uninstall.
* Now passing user/password to install calls

## 2.0.4
* Changing --install to /install

## 2.0.3
* Removed comma from list

## 2.0.2
* Fixed loop issue

## 2.0.1
* Fixed auth data bag typo

## 2.0.0
* Created recipe for installing windows external data components

## 1.0.3
* Adding the ability to adjust mapred.child.hava.opts by conf file

## 1.0.2:
* Fix a bad variable that failed runs

## 1.0.1:
* the path to hbase was corrected in the file hbasetable.py

## 1.0.0:
* Remove the ZooKeeper fallback if search fails
* Food critic warnings addressed

## 0.0.6:
*  adding template changes for max hours processed

## 0.0.5:
* Remove default download URL to the latest in TeamCity
* Reformatting and food critic fixes

## 0.0.4:
* includes fix for adding to jobtracker the mapreduce apps (facebook/twitter)

## 0.0.3:
* fix of ENG392547 around scan timeouts
* also includes twitter fix ENG392552
* also changed the environment.properties file to include a setting for hbase region lease timeouts for scan
* fixed ENG392544:  Retweet Key Metic total is incorrect

# 0.0.2:
* to support facebook adhering to a constant highwater mark and not resetting itself

# 0.0.1:
* initial release

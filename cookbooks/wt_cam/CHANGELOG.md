## 1.0.15
* Adding in missing windows_zipfile resource
## 1.0.14
* Reverting port back to 82
* Changed cam_lite_port to camlite_port
## 1.0.13
* Changed CamLite port to 85
## 1.0.12
* Fixed spacing and removed check around firewall rule.
## 1.0.11
* Changed CamLite to use installdir instead of hardcoded path.
## 1.0.10
* Added attributes for the port numbers for cam, auth and cam_lite 
* removed hard-coded values for same

## 1.0.9
* Separated Auth service from the Cam
* Updated cam cookbook and web.config template
* Added web.config template for Auth
* Added install and uninstall recipes for Auth

## 1.0.8
* Web.config template again - format of connection string changed

## 1.0.7
* Updated the web.config template with the correct database connection string

## 1.0.6
* Changed the database name to match the db deploy

## 1.0.5
* Added a cam_lite recipe to split the old stuff out. This will eventually go away

## 1.0.4
* removed camdb_user and change web.config to use Trusted_Connection
* changed service account to be ui_user
* gave ui_user modify access to install_dir, so logging can occur
* added db_name attib which defaults to wt_CamLite, but we should use wtCamLite to match systemdb naming convention.
* set CAM site folder to an empty folder at c:\inetpub\wwwroot, only CamService vApp uses install_dir

## 1.0.1:
* Change URL attribute to download_url to match other products

## 1.0.0:
* Initial release

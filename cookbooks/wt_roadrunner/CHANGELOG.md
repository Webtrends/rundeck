## 1.1.2
* renamed system database attributes

## 1.1.1
* changed windows_zipfile source
* moved templates out of deploy section
* added notifications to service resource when service is deployed or templates change
* fixed misplaced quote sc delete command

## 1.1.0
* Change README from rdoc to md
* Don't use wt_base to pull the build.  Just use the windows_zipfile resource
* Change zip_file/build_url to just download_url so it matches our other cookbooks
* Add the same blocks we use to run the uninstaller if we are in deploy_build=true mode
* Correctly name the template files

## 1.0.1
* Remove valid TeamCity download URL

## 1.0.0
* Address food critic warnings

## 0.10.5:
* Initial release with a changelog

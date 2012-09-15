## 1.0.7
* Don't use the deploy flag.  This breaks setups where NetAcuity sits with other WT services and wipes away the DBs / breaks NetAcuity for over and hour post deploy of the WT services
* Delete the init script on uninstall

## 1.0.6
* Address several food critic warnings

## 1.0.5
* Remove wt_base code.  There's no need for it
* Remove missing data bag catches that weren't working

## 1.0.4
* Wrap the recipe in a deploy flag since this recipe will never leave webtrends
* Template the password file from the authorization data bag

## 1.0.3
* Fix passing the version attribute into the template

## 1.0.2:
* Use NetAcuity 5.0 by default.  There's no reason to pin to 4.6 as was required in Optimize

## 1.0.1:
* Attempt to fix the gating

## 1.0.0:

* Initial transfer from Optimize
* Allow installing to any directory
* Move attributes out of databags an into environments
* Host NetAcuity in the repo and not as a cookbook file
* General cleanup to do things how they should be done
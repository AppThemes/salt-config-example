AppThemes SaltStack (Configuration Management Sources)
------------------------------------------------------

In August 2012 AppThemes.com started working on the new infrastructure.
SaltStack was decided to be the tool that should handle any operation 
within new infrastructure (from configuration management to deployments).

AppThemes stack is mainly PHP and MySQL (WordPress). The team uses Git a lot.

This repository is a snapshot of our salt `sls` files (with sensitive parts removed).

The purpose of this, is to help other interested parties in getting familiar
with SaltStack and share some of our experience/knowledge while working with it.

Hints on what might be interesting while browsing this repository:

* DRY approach
* `sls` files organization (it should deploy just by using `state.sls`)
* `vhosts` folder
* `apt` folder
* `monit` folder
* `jenkins` folder
* `firewall` folder

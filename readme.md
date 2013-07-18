AppThemes SaltStack (Configuration Management Sources)
------------------------------------------------------

In August 2012 we started working on a new infrastructure for our [website](http://appthemes.com).
We chose SaltStack to be the tool that handles any operation
within this new infrastructure (from configuration management to deployments).

This repository is a snapshot of our salt `sls` files (with sensitive parts removed).

The idea is to help other interested parties in getting familiar
with SaltStack and share some of our experience/knowledge while working with it.

Our stack is basically LEMP - Ubuntu, Nginx, MySQL and PHP (WordPress). We use Git a lot.

Hints on what might be interesting while browsing this repository:

* `sls` files organization (it should deploy just by using `state.sls`)
* `vhosts` folder
* `apt` folder
* `monit` folder
* `jenkins` folder
* `firewall` folder

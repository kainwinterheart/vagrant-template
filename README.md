vagrant-template
================

A template to help bootstrap new vagrant projects.

1. Clone this repo.
1. Make sure you have [vagrant installed](http://vagrantup.com).
1. Make sure you have Virtualbox installed(http://www.virtualbox.org).
1. Run `vagrant up` to set up  the virtual machine.
1. Run `vagrant ssh` to connect into the virtual machine
1. Run `vagrant provision` to re-run chef after changing chef recipes.

Port 8000 from the local host is forwarded into the vagrant machine, so
run your webapp listening on that port and you can access it from the host
using http://localhost:8000. Changes made to code in this directory are reflected
inside the vagrant machine using a shared folder.

You can access the vagrant machine from inside other virtualbox machines
such as the [IEVMS](https://github.com/xdissent/ievms) project by going to http://192.168.50.50:8000.

See TODO

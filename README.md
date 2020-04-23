# datagather testing environment
Testing environment for datamine/datagather Scripting

### Purpose
This is the non-Proprietary test environment for an internal project. It is placed in the public domain to provide an example of how one might go about creating a local vagrant/Virtualbox test environment that support multiple platforms.

### The Vagrant/VirtualBox setup
Basically this is just a plan vanilla VirtaulBox and Vagrant setup except for th inclusion of vagrant-hosts plugins for vagrant.

### Box setups
The boxes I have used in my setup are a mixture of publicly avail boxes from vagrant cloud https://app.vagrantup.com/boxes/search and boxes built with packer using chef bento box sources at https://github.com/chef/bento. Part of the reason I have utilized both is that some of the boxes either don't the VirtualBox extension or they are not fully functional. The extensions are helpful in mounting the source directories as virtulabox mounts for the environments under test. There are still some boxes that still need to sync the folder via rsync, which means any time a source is changed the box needs to be destroyed and rebuilt to ensure syncing with the latest change. FreeBSD was one such instance. The sync mode is a variable you can set in your node.yaml file on a per box basis.

### The node.yaml file
This file exists to define details of the various platforms under test. It is read from the Vagrantfile and its values get converted to hashes to provide the necessary variables to control building of the boxes.

### The Vagrantfile
Since the Vagrantfile is basically just a ruby script there is a lot of flexibility on how you set it up. 


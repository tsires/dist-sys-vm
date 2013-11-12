#!/bin/bash
# quick and dirty script to get dist-sys-x VMs up to speed
# requires sudo

SUDO=''
if [ "$UID" -ne 0 ]; then
	SUDO='sudo'
fi

# packages
PACKAGES=('python-dev' 'python3-dev' 'vim' 'dvtm' 'libtool' 'autoconf' 'automake')
PACKAGES+=('mongodb-10gen' 'zookeeper' 'msgpack-python' 'python-pip' 'python3-pip')
PACKAGES+=('uuid-dev' 'git')

# add repo info for mongodb
$SUDO apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | $SUDO tee /etc/apt/sources.list.d/mongodb.list

# post clone update
$SUDO apt-get update
$SUDO apt-get upgrade\
	--yes

# install packages
$SUDO apt-get install $PACKAGES\
	--yes  

# install pymongo
$SUDO pip install pymongo
$SUDO pip3 install pymongo

# get and install zmq
cd /tmp/
wget 'http://download.zeromq.org/zeromq-3.2.2.tar.gz' -O 'zeromq-3.2.2.tar.gz'
tar --no-same-owner --no-same-permissions -zxf 'zeromq-3.2.2.tar.gz'
cd 'zeromq-3.2.2'
./configure && make && $SUDO make install

# install python binding for zmq
$SUDO pip install pyzmq
$SUDO pip3 install pyzmq

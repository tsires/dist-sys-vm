#!/bin/bash
# quick and dirty script to get dist-sys-x VMs up to speed
# requires sudo

# packages
PACKAGES='python-dev python3-dev vim dvtm libtool autoconf automake '
PACKAGES+='mongodb-10gen zookeeper msgpack-python python-pip python3-pip'
PACKAGES+='uuid-dev git '

# add repo info for mongodb
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

# post clone update
apt-get update
apt-get upgrade\
	--yes

# install packages
apt-get install $PACKAGES\
	--yes  

# install pymongo
pip install pymongo
pip3 install pymongo

# get and install zmq
cd ~
wget http://download.zeromq.org/zeromq-3.2.2.tar.gz
tar zxvf zeromq-3.2.2.tar.gz
cd zeromq-3.2.2
./configure
make && make install

# install python binding for zmq
pip install pyzmq
pip3 install pyzmq

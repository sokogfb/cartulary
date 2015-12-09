#!/bin/bash

##: This script needs to be run with sudo
ROOT_UID="0"

#Check if run as root
if [ "$UID" -ne "$ROOT_UID" ] ; then
	echo "You must run this script with sudo."
	exit 1
fi
export CARTROOT=`echo "<?echo rtrim(get_cfg_var('cartulary_conf'), '/');?>" | php`

echo Side-loading packages up through version 0.6.10...

##: Refresh apt
echo Updating apt-get repos...
apt-get update

##: Install any new modules needed for this release
echo Installing php5 imap library...
apt-get install -y php5-imap
php5enmod imap

echo Installing php5 xsl library...
apt-get install -y php5-xsl
php5enmod xsl

echo Installing node.js...
apt-get install -y nodejs npm
sudo update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10
cd $CARTROOT/aggrivate
npm install


##: This file should be EXEcutable!
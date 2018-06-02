#!/bin/bash -e

mkdir -p /home/vagrant/dshield
chown vagrant:vagrant /home/vagrant/dshield

sudo mkdir -p /etc/apt/apt.conf.d
# sudo cat >/etc/apt/apt.conf.d/proxy <<PROXY
# Acquire::http::Proxy "http://192.168.1.254:3142/";
# PROXY

# These installations have been scraped from install.sh and need to be kept up to date.
apt-get -y install build-essential curl dialog gcc git libffi-dev libmpc-dev libmpfr-dev libpython-dev libswitch-perl libwww-perl python-dev python2.7-minimal randomsound rng-tools unzip libssl-dev python-virtualenv authbind python-requests python-urllib3 zip

wget -qO $TMPDIR/get-pip.py https://bootstrap.pypa.io/get-pip.py
sudo python $TMPDIR/get-pip.py
sudo pip download requests
rm $TMPDIR/get-pip.py

sed -i.bak 's/^[#\s]*Port 22\s*$/Port "12222"/' /etc/ssh/sshd_config

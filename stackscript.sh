#! /bin/bash
mkdir -p /srv/logs
#-# Get the git repos
apt install -y git > /srv/logs/setup.log 2>&1

git clone https://github.com/Jekotia/srv-mercury.git /srv/mercury >> /srv/logs/setup.log 2>&1
/srv/logs/setup.log
bash /srv/mercury/setup.sh >> /srv/logs/setup.log 2>&1

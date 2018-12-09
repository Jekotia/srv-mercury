#! /bin/bash
#-# Variable to tell any subsequent scripts that this is a stackscript run. This will allow me to keep my scripts flexible and work standalone as well.
export SETUP=stackscript

#<UDF name="new_user_name" label="Primary users' name">
#<UDF name="new_user_pass" label="Primary users' password">
#<UDF name="new_user_pubkey" label="Primary users' publickey">
#<UDF name="hostname" label="The hostname for the new Linode.">
#<UDF name="fqdn" label="The new Linode's Fully Qualified Domain Name">
export new_user_name
export new_user_pass
export new_user_pubkey
export hostname
export fqdn

#-# Get the git repos
apt install -y git > /srv/setup.log 2>&1

mkdir /srv >> /srv/setup.log 2>&1
git clone https://github.com/Jekotia/srv-common.git /srv/common >> /srv/setup.log 2>&1
git clone https://github.com/Jekotia/srv-mercury.git /srv/mercury >> /srv/setup.log 2>&1

bash /srv/mercury/setup.sh >> /srv/setup.log 2>&1
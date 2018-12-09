#! /bin/bash
if ! git --version ; then
	apt install -y git
fi

git clone https://github.com/Jekotia/srv-common.git /srv/common

#export _COMMON=/srv/common
#echo "_COMMON=/srv/common" >> /etc/environment
#export _ROOT=/srv/mercury
#echo "_ROOT=/srv/mercury" >> /etc/environment

#-# Setup the environment
/srv/common/bin/build-environment

#-# Source all functions
source ${_SCRIPT_INIT}

#-# Initial Setup
	#-# Puppet
	install_puppet
	puppet module install puppetlabs-stdlib --version 4.25.1
	puppet module install puppetlabs-docker --version 3.1.0
	puppet module install saz-sudo --version 5.0.0
	puppet module install saz-ssh --version 4.0.0

	puppet apply ${_PUPPET_MERCURY_MANIFESTS}

	#-# User Setup
	#user_add_sudo "${new_user_name}" "${new_user_pass}"
	#user_add_pubkey "${new_user_name}" "${new_user_pubkey}"
	#ssh_disable_root

	#-# System
	#system_set_hostname "${hostname}"
	#system_add_host_entry "$(system_primary_ip)" "${fqdn}"

	#-# Packages
	#package update
	#package upgrade
	#package install aptitude
	#aptitude -y full-upgrade

	#-# Software
	install_shell "$_USER"
	#install_docker_engine
	#install_docker_compose
	#install_puppet

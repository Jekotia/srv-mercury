#! /bin/bash

#-> KEY VARIABLES
#-> PATH TO SRV-COMMON REPO
cPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../common"

#-> ENSURE GIT IS PRESENT
if ! git --version  > /dev/null 2>&1 ; then
	yum install -y git
fi

#if ! dig --version  > /dev/null 2>&1 ; then
#	yum install -y dnsutils
#fi

git clone --single-branch --branch centos --recurse-submodules https://github.com/Jekotia/srv-common.git /srv/common

#export _COMMON=/srv/common
#echo "_COMMON=/srv/common" >> /etc/environment
#export _ROOT=/srv/mercury
#echo "_ROOT=/srv/mercury" >> /etc/environment


#-# Source all functions
source ${cPATH}/init

#-# Setup the environment
source /srv/common/bin/build-environment

#-# Initial Setup
	#-# Puppet

	#install_puppet
	package_InstallFromFile "https://yum.puppet.com/puppet6-release-el-7.noarch.rpm"
	package_install --unattended "puppet-agent"

	puppet module install puppetlabs-stdlib --version 4.25.1
	puppet module install puppetlabs-docker --version 3.1.0
	puppet module install saz-sudo --version 5.0.0
	puppet module install saz-ssh --version 4.0.0
	puppet module install puppet-python --version 2.2.2
	puppet module install puppetlabs-vcsrepo --version 2.4.0
	puppet module install saz-timezone --version 5.0.2
	puppet module install jethrocarr-hostname --version 1.0.3
	puppet module install puppet-unattended_upgrades --version 3.2.1
	puppet module install puppetlabs-apt --version 6.3.0
	# ? puppet module install puppet-openvpn --version 7.4.0

	puppet apply ${_PUPPET_ROOT}/manifests

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

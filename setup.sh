#! /bin/bash

#-> KEY VARIABLES
#-> PATH TO SRV-COMMON REPO
cPATH="/srv/common"

#-> ENSURE GIT IS PRESENT
if ! git --version > /dev/null 2>&1 ; then
	yum install -y git
fi

#if ! dig --version > /dev/null 2>&1 ; then
#	yum install -y dnsutils
#fi

git clone --single-branch --branch centos --recurse-submodules https://github.com/Jekotia/srv-common.git ${cPATH}

#-> SOURCE FUNCTIONS
source ${cPATH}/init

#-> ENSURE SUPERUSER BEFORE GOING ANY FURTHER
isRoot "exit"

#-> SETUP ENVIRONMENT VARIABLES
source ${cPATH}/bin/build-environment

#-> INITIAL SETUP
	#-# PUPPET
		#-> INSTALL THE CENTOS REPO RPM
		package_InstallFromURL "https://yum.puppet.com/puppet6-release-el-7.noarch.rpm"
		#-> INSTALL THE AGENT FROM THE REPO ADDED ABOVE
		package_install --unattended --verbose "puppet-agent"

		#-> PUPPET INSTALLS TO A NON-STANDARD LOCATION FOR BINARIES; LETS CREATE A SYMLINK TO /USR/BIN
		ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet

		#-> PUPPET MODULES REQUIRED BY THE PUPPETFILES IN THIS REPO
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

		#-> APPLY THE PUPPET MANIFESTS FROM THIS REPO
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

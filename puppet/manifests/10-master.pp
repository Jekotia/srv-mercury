host { "system":
	name		=> "$_NAME",
	ensure		=> "present",
	ip		=> "$_IP",
}

class {"hostname":
        hostname        => "mercury",
        domain          => "jekotia.net"
}

class { 'timezone':
    timezone => 'America/Toronto',
}

cron { "ddns-update":
	ensure		=> "present",
	environment	=> "MAILTO=alerts@jekotia.net",
	command		=> "$_SCRIPT_DDNS > /dev/null 2>&1",
	user		=> "jekotia",
	minute		=> "*/5",
	hour		=> "absent",
	monthday	=> "absent",
	month		=> "absent",
	weekday		=> "absent",
	special		=> "absent",
}

# Symlinks

file { "/etc/nginx":
	ensure		=> "link",
	target		=> "$_NGINX_DATA",
}

file { "server data folder":
	path		=> "$_DATA",
	ensure		=> "directory",
}

file { "server logs folder":
	path		=> "$_LOGS",
	ensure		=> "directory",
}

#class { 'ssh::server':
#  storeconfigs_enabled => false,
#  options => {
#    'PasswordAuthentication' => 'no',
#    'PermitRootLogin'        => 'no',
#    'Port'                   => [22, 2222],
#  },
#}

class { 'unattended_upgrades':
	age => {
		'min' 			=> 10,
		'max' 			=> 10
	},
	auto => {
		'reboot'		=> false,
		'fix_interrupted_dpkg'	=> true,
		'remove'		=> true
	},
	enable 				=> 1,
	install_on_shutdown		=> false,
	legacy_origin			=> false,
	mail => {
		'to'			=> 'joshua.ameli@gmail.com'
	},
	minimal_steps			=> true,
	origins => [
		'http://mirrors.linode.com/debian stretch main',
		'http://mirrors.linode.com/debian-security stretch/updates main',
		'http://mirrors.linode.com/debian stretch-updates main'
	],
	package_ensure			=> installed,
	update				=> 1,
	upgrade				=> 1,
	upgradeable_packages => {
		'debdelta'		=> 1
	},
}

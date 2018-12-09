host { "system":
	name		=> "$_NAME",
	ensure		=> "present",
	ip		=> "$_IP",
}

cron { "ddns-update":
	ensure		=> "present",
	command		=> "$_SCRIPT_DDNS > /dev/null 2>&1",
	user		=> "root",
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

class { 'ssh::server':
  storeconfigs_enabled => false,
  options => {
    'PasswordAuthentication' => 'no',
    'PermitRootLogin'        => 'no',
#    'Port'                   => [22, 2222],
  },
}

cron { "rsnapshot hourly":
	ensure		=> "present",
	environment	=> "MAILTO=alerts@jekotia.net",
	command		=> "rsnapshot hourly",
	user		=> "root",
	minute		=> "0",
	hour		=> "absent",
	monthday	=> "absent",
	month		=> "absent",
	weekday		=> "absent",
	special		=> "absent",
}

cron { "rsnapshot daily":
	ensure		=> "present",
	environment	=> "MAILTO=alerts@jekotia.net",
	command		=> "rsnapshot daily",
	user		=> "root",
	minute		=> "0",
	hour		=> "0",
	monthday	=> "absent",
	month		=> "absent",
	weekday		=> "absent",
	special		=> "absent",
}

cron { "rsnapshot weekly":
	ensure		=> "present",
	environment	=> "MAILTO=alerts@jekotia.net",
	command		=> "rsnapshot weekly",
	user		=> "root",
	minute		=> "0",
	hour		=> "0",
	monthday	=> "absent",
	month		=> "absent",
	weekday		=> "0",
	special		=> "absent",
}

cron { "rsnapshot monthly":
	ensure		=> "present",
	environment	=> "MAILTO=alerts@jekotia.net",
	command		=> "rsnapshot monthly",
	user		=> "root",
	minute		=> "0",
	hour		=> "0",
	monthday	=> "1",
	month		=> "absent",
	weekday		=> "absent",
	special		=> "absent",
}

file { "/etc/rsnapshot.conf":
	ensure		=> "link",
	target		=> "$_DATA/rsnapshot.conf",
}

package { "rsnapshot":	ensure	=> "installed" }

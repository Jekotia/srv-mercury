cron { "rsnapshot hourly":
	ensure		=> "present",
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

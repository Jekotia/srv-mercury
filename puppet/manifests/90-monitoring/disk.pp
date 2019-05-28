cron { "disk-monitor":
	ensure		=> "present",
	environment	=> "MAILTO=alerts@jekotia.net",
	command		=> "/srv/common/scripts/monitoring/disk.sh",
	user		=> "root",
	minute		=> "*/30",
	hour		=> "absent",
	monthday	=> "absent",
	month		=> "absent",
	weekday		=> "absent",
	special		=> "absent",
}

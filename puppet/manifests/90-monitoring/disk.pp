cron { "disk-monitor":
	ensure		=> "present",
	command		=> "/srv/common/scripts/monitoring/disk.sh",
	user		=> "root",
	minute		=> "*/30",
	hour		=> "absent",
	monthday	=> "absent",
	month		=> "absent",
	weekday		=> "absent",
	special		=> "absent",
}

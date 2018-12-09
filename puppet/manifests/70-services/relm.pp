cron { "relm":
	ensure		=> "present",
	command		=> "cd $_RELM && python3 $_RELM/relm.py github --user=jekotia > /dev/null 2>&1",
	user		=> "pi",
	minute		=> "*/30",
	hour		=> "absent",
	monthday	=> "absent",
	month		=> "absent",
	weekday		=> "absent",
	special		=> "absent",
}
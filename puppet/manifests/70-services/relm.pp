#python::pyvenv { "/srv/virtualenv/relm" :
#  ensure       => present,
#  version      => "system",
#  systempkgs   => false,
#  owner        => "jekotia",
#  group        => "jekotia",
#}
file { "$_VIRTUAL_ENV":
	ensure		=> 'directory',
	owner		=> 'root',
}

#file { "$_RELM":
#	ensure		=> 'directory',
#	owner		=> 'jekotia',
#}

vcsrepo { "$_RELM":
  ensure   => present,
  provider => git,
  source   => "https://github.com/jekotia/relm.git",
}

python::virtualenv { "/srv/virtualenv/relm" :
	ensure			=> present,
	version			=> "3.5",
	requirements		=> "$_RELM/requirements.txt",
	systempkgs		=> false,
#	venv_dir		=> "/home/appuser/virtualenvs",
	ensure_venv_dir		=> true,
	distribute		=> false,
#	index			=> "appuser",
	owner			=> "jekotia",
	group			=> "jekotia",
#	proxy			=> "http://proxy.domain.com:3128",
#	cwd			=> "/var/www/project1",
#	timeout			=> 0,
#	extra_pip_args		=> "--no-binary :none:",
#	extra_pip_args		=> ""
}

cron { "relm":
	ensure		=> "present",
	command		=> "cd $_RELM && /srv/virtualenv/relm/bin/python3.5 $_RELM/relm.py github --user=jekotia > /dev/null 2>&1",
	user		=> "jekotia",
	minute		=> "*/30",
	hour		=> "absent",
	monthday	=> "absent",
	month		=> "absent",
	weekday		=> "absent",
	special		=> "absent",
}

user { "$_DEHYDRATED_USER":
	ensure		=> "present",
	uid		=> "$_DEHYDRATED_UID",
	gid		=> "$_DEHYDRATED_GID",
	membership	=> "inclusive",
	system		=> "true",
}
group { "$_DEHYDRATED_GROUP":
	ensure		=> "present",
	gid		=> "$_DEHYDRATED_GID",
	system		=> "true",
}

cron { "dehydrated-ssl":
	ensure		=> "present",
	command		=> "$_ROOT/ssl/run.sh -c",
	user		=> "root",
	minute		=> "0",
	hour		=> "absent",
	monthday	=> "absent",
	month		=> "absent",
	weekday		=> "absent",
	special		=> "absent",
}

file { "dehydrated data folder":
	path		=> "$_DEHYDRATED_DATA",
	ensure		=> "directory",
	group		=> "$_DEHYDRATED_GID",
	owner		=> "$_DEHYDRATED_UID",
	recurse		=> "true",
}

package { "build-essential":	ensure  => "installed" }
package { "python-dev":		ensure  => "installed" }
package { "curl":		ensure  => "installed" }
package { "libffi-dev":		ensure  => "installed" }
package { "libssl-dev":		ensure  => "installed" }
package { "python3":		ensure  => "installed" }

ensure_packages(['requests[security]', 'dns-lexicon'], {
	ensure   => present,
	provider => 'pip3',
#	require  => [ Package['python3-pip'], ],
})

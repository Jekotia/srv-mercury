user { "$_PORTAINER_USER":
	ensure		=> "present",
	uid		=> "$_PORTAINER_UID",
	gid		=> "$_PORTAINER_GID",
	membership	=> "inclusive",
	system		=> "true",
}
group { "$_PORTAINER_GROUP":
	ensure		=> "present",
	gid		=> "$_PORTAINER_GID",
	system		=> "true",
}

file { "portainer data folder":
	path		=> "$_PORTAINER_DATA",
	ensure		=> "directory",
	group		=> "$_PORTAINER_GID",
	owner		=> "$_PORTAINER_UID",
	recurse		=> "true",
}

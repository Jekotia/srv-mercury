user { "$_PROXY_USER":
	ensure		=> "present",
	uid		=> "$_PROXY_UID",
	gid		=> "$_PROXY_GID",
	membership	=> "inclusive",
	system		=> "true",
}
group { "$_PROXY_GROUP":
	ensure		=> "present",
	gid		=> "$_PROXY_GID",
	system		=> "true",
}

file { "proxy data folder":
	path		=> "$_PROXY_DATA",
	ensure		=> "directory",
	group		=> "$_PROXY_GID",
	owner		=> "$_PROXY_UID",
	recurse		=> "true",
}

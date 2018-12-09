user { "$_GOGS_USER":
	ensure		=> "present",
	uid		=> "$_GOGS_UID",
	gid		=> "$_GOGS_GID",
	membership	=> "inclusive",
	system		=> "true",
}
group { "$_GOGS_GROUP":
	ensure		=> "present",
	gid		=> "$_GOGS_GID",
	system		=> "true",
}

file { "gogs data folder":
	path		=> "$_GOGS_DATA",
	ensure		=> "directory",
	group		=> "$_GOGS_GID",
	owner		=> "$_GOGS_UID",
	recurse		=> "true",
}

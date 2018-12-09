user { "$_ALERTHUB_USER":
	ensure		=> "present",
	uid		=> "$_ALERTHUB_UID",
	gid		=> "$_ALERTHUB_GID",
	membership	=> "inclusive",
	system		=> "true",
}
group { "$_ALERTHUB_GROUP":
	ensure		=> "present",
	gid		=> "$_ALERTHUB_GID",
	system		=> "true",
}

file { "alerthub folder":
	path		=> "$_ALERTHUB_DATA",
	ensure		=> "directory",
	group		=> "$_ALERTHUB_GID",
	owner		=> "$_ALERTHUB_UID",
	recurse		=> "true",
}

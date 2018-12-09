user { "$_DISCORDIRC_USER":
	ensure		=> "present",
	uid		=> "$_DISCORDIRC_UID",
	gid		=> "$_DISCORDIRC_GID",
	membership	=> "inclusive",
	system		=> "true",
}
group { "$_DISCORDIRC_GROUP":
	ensure		=> "present",
	gid		=> "$_DISCORDIRC_GID",
	system		=> "true",
}

file { "discordirc data folder":
	path		=> "$_DISCORDIRC_DATA",
	ensure		=> "directory",
	group		=> "$_DISCORDIRC_GID",
	owner		=> "$_DISCORDIRC_UID",
	recurse		=> "true",
}

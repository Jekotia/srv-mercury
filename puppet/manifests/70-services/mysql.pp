user { "$_MYSQL_USER":
	ensure		=> "present",
	uid		=> "$_MYSQL_UID",
	gid		=> "$_MYSQL_GID",
	membership	=> "inclusive",
	system		=> "true",
}
group { "$_MYSQL_GROUP":
	ensure		=> "present",
	gid		=> "$_MYSQL_GID",
	system		=> "true",
}

file { "MySQL data folder":
	path		=> "$_MYSQL_DATA",
	ensure		=> "directory",
	group		=> "$_MYSQL_GID",
	owner		=> "$_MYSQL_UID",
	recurse		=> "true",
}

#user { "$_TTRSS_USER":
#	ensure		=> "present",
#	uid		=> "$_TTRSS_UID",
#	gid		=> "$_TTRSS_GID",
#	membership	=> "inclusive",
#	system		=> "true",
#}
#group { "$_TTRSS_GROUP":
#	ensure		=> "present",
#	gid		=> "$_TTRSS_GID",
#	system		=> "true",
#}

file { "TTRSS data folder":
	path		=> "$_TTRSS_DATABASE_DATA",
	ensure		=> "directory",
#	group		=> "$_TTRSS_GID",
#	owner		=> "$_TTRSS_UID",
#	recurse		=> "true",
}

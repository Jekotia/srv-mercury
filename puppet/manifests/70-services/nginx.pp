user { "$_NGINX_USER":
	ensure		=> "present",
	uid		=> "$_NGINX_UID",
	gid		=> "$_NGINX_GID",
	membership	=> "inclusive",
	system		=> "true",
}
group { "$_NGINX_GROUP":
	ensure		=> "present",
	gid		=> "$_NGINX_GID",
	system		=> "true",
}

file { "nginx data folder":
	path		=> "$_NGINX_DATA",
	ensure		=> "directory",
	group		=> "$_NGINX_GID",
	owner		=> "$_NGINX_UID",
	recurse		=> "true",
}

file { "telegraf data folder":
	path		=> "$_TELEGRAF_DATA",
	ensure		=> "directory",
#	group		=> "$_TELEGRAF_GID",
#	owner		=> "$_TELEGRAF_UID",
	recurse		=> "true",
}

file { "influxdb data folder":
	path		=> "$_INFLUXDB_DATA",
	ensure		=> "directory",
#	group		=> "$_INFLUXDB_GID",
#	owner		=> "$_INFLUXDB_UID",
	recurse		=> "true",
}

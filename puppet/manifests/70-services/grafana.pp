file { "grafana data folder":
	path		=> "$_GRAFANA_DATA",
	ensure		=> "directory",
#	group		=> "$_GRAFANA_GID",
	owner		=> "$_GRAFANA_UID",
	recurse		=> "true",
}

file { "grafana storage folder":
	path		=> "$_GRAFANA_DATA/storage",
	ensure		=> "directory",
#	group		=> "$_GRAFANA_GID",
	owner		=> "$_GRAFANA_UID",
	recurse		=> "true",
}

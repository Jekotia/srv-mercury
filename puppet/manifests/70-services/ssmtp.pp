file { "/etc/ssmtp":
	ensure		=> "link",
	target		=> "$_DATA/ssmtp",
}
package { "ssmtp":	ensure	=> "installed" }
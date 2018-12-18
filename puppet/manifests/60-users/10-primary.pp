package { "zsh":	ensure	=> "installed" }

user { "jekotia":
	ensure			=> present,
	managehome	=> "true",
	shell				=> "/bin/zsh",
	comment			=> "Primary user"
#	purge_ssh_keys => true,
}

class { "sudo": }
sudo::conf { "jekotia":
	ensure		=> "present",
	priority	=> 99,
	content		=> "jekotia ALL=(ALL) NOPASSWD: ALL",
}

ssh_authorized_key { "jameli@jupiter":
	ensure => present,
	user   => "jekotia",
	type   => "ssh-rsa",
	key    => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDRvdduzwOuCMFHXEDOyH1gB/WiQXO/mf/D+tWllIXhEqUPap73jmVU/Rx3MMLPaitHpTQ1ULl8UnwxsI4ZnZeRMlvomGtUHXL2wMFViEXSV3TJOt9KJu6hj5HR9/uI/c8z3iu6pA06oGyXHJ8qv+woF1f2icojmUk0tIH3Fqa3SMNdmW1u+kw1dk0UcxtV8XgLb+hRVZqVPbopttwn6Er7CT45ad00dog7YAIlm3gCFOlyIBJzTvCOcgInU7jpnnmXJyIkEIzjmphS0GRwr4sHNZSN8kOOy+H3y9XhM7fO4WNHRhIUPY7TScFormAJW4fZKzopiGp/1jiSB1yN6jC1",
}

#vcsrepo { "/home/jekotia/.zsh":
#  ensure   => present,
#  provider => git,
#  source   => "https://github.com/Jekotia/.zsh.git",
#}

#package { "wget"
#wget curl nano zsh git bc

#class basic_exec {
#	exec { "":
#		command => "shell-setup-local.sh",
#		path    => "/home/jekotia/.zsh/",
#		#path    => [ "/usr/local/bin/", "/bin/" ],  # alternative syntax
#	}
#}

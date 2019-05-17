#package { "python3":      ensure	=> "installed" }
#package { "python3-pip":  ensure	=> "installed" }
#package { "python3-venv":  ensure	=> "installed" }

class { 'python' :
#  version    => '3.6',
  pip        => 'present',
  dev        => 'present',
  virtualenv => 'present',
  gunicorn   => 'absent',
}

package { "gawk":	ensure	=> "installed" }
package { "git":	ensure	=> "installed" }
package { "htop":	ensure	=> "installed" }
package { "moreutils":	ensure	=> "installed" }

#package { "python3":      ensure	=> "installed" }
#package { "python3-pip":  ensure	=> "installed" }
#package { "python3-venv":  ensure	=> "installed" }

class { 'python' :
  version    => '3.5',
  pip        => 'present',
  dev        => 'absent',
  virtualenv => 'present',
  gunicorn   => 'absent',
}

package { "git":          ensure	=> "installed" }

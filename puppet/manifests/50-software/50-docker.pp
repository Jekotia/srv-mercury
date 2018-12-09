#include 'docker'

class { 'docker':
  docker_users => ['jekotia'],
}

package { "python3":	ensure	=> "installed" }
package { "python3-pip":	ensure	=> "installed" }


ensure_packages(['docker-compose'], {
	ensure   => present,
	provider => 'pip3',
#	require  => [ Package['python3-pip'], ],
})
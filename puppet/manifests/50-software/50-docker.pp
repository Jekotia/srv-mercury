#include 'docker'

class { 'docker':
  docker_users => ['jekotia'],
}

ensure_packages(['docker-compose'], {
	ensure   => present,
	provider => 'pip3',
#	require  => [ Package['python3-pip'], ],
})

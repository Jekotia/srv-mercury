class { 'docker':
  docker_users => ['jekotia'],
}
class {'docker::compose':
  ensure => present,
  version => '1.22.0',
}

#ensure_packages(['docker-compose'], {
#	ensure   => present,
#	provider => 'pip',
#	require  => [ Package['python3-pip'], ],
#})

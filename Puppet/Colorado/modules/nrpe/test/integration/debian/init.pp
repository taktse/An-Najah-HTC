# -*- puppet -*-

exec { 'apt-get update':
  command => 'apt-get update -qq',
  path    => [ '/usr/bin', '/usr/sbin', '/bin', '/sbin' ],
}

class { 'nrpe':
  package       => true,
  service       => true,
  allowed_hosts => [ '127.0.0.1', '10.0.0.0/8' ],
  require       => Exec[ 'apt-get update' ],
}

nrpe::command {
  'check_memory':
    command => 'check_memory'
}
# EOF

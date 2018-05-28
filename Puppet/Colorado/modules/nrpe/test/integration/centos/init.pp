# -*- puppet -*-

exec { 'yum update':
  command => 'yum update -q -y && yum install -q -y epel-release',
  path    => [ '/usr/bin', '/usr/sbin', '/bin', '/sbin' ],
}

class { 'nrpe':
  allowed_hosts => [ '127.0.0.1' ],
  require       => Exec[ 'yum update' ],
}

nrpe::command {
  'check_memory':
    command => 'check_memory'
}
# EOF

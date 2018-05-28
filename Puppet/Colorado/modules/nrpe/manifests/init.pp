# == Class: nrpe
#
# Puppet module to install, deploy and configure nrpe.
#
class nrpe (
  $package                 = true,
  $service                 = true,
  $enable                  = true,
  $systemd                 = $nrpe::params::systemd,
  $nrpe_package_name       = $nrpe::params::nrpe_package_name,
  $nrpe_package_deps       = $nrpe::params::nrpe_package_deps,
  $nrpe_service_name       = $nrpe::params::nrpe_service_name,
  $nrpe_user_name          = $nrpe::params::nrpe_user_name,
  $nrpe_group_name         = $nrpe::params::nrpe_group_name,
  $nrpe_sysconfig          = $nrpe::params::nrpe_sysconfig,
  $nrpe_systemd            = $nrpe::params::nrpe_systemd,
  $nrpe_options            = $nrpe::params::nrpe_options,
  $nrpe_config             = $nrpe::params::nrpe_config,
  $nrpe_plugins            = $nrpe::params::nrpe_plugins,
  # daemon settings
  $log_facility            = $nrpe::params::log_facility,
  $pid_file                = $nrpe::params::pid_file,
  $server_port             = $nrpe::params::server_port,
  $server_address          = $nrpe::params::server_address,
  $nrpe_user               = $nrpe::params::nrpe_user_name,
  $nrpe_group              = $nrpe::params::nrpe_group_name,
  $allowed_hosts           = $nrpe::params::allowed_hosts,
  $dont_blame_nrpe         = $nrpe::params::dont_blame_nrpe,
  $debug                   = $nrpe::params::debug,
  $command_timeout         = $nrpe::params::command_timeout,
  $connection_timeout      = $nrpe::params::connection_timeout,
  $include                 = $nrpe::params::include,
  $include_dir             = $nrpe::params::include_dir,
  # plugins settings
  $check_disk_exclude_type = $nrpe::params::check_disk_exclude_type
) inherits nrpe::params {
  case $package {
    true    : { $ensure_package = 'present' }
    false   : { $ensure_package = 'purged' }
    latest  : { $ensure_package = 'latest' }
    default : { fail('package must be true, false or lastest') }
  }

  case $service {
    true    : { $ensure_service = 'running' }
    false   : { $ensure_service = 'stopped' }
    default : { fail('service must be true or false') }
  }

  package { $nrpe_package_deps:
    ensure => $ensure_package,
  }

  package { $nrpe_package_name:
    ensure  => $ensure_package,
    require => Package[$nrpe_package_deps],
  }

  # systemd
  if ($::lsbdistcodename  == 'stretch') or
    ($::lsbdistcodename  == 'buster') {
    file { $systemd:
      ensure  => 'directory',
      mode    => '0755',
      require => Package[$nrpe_package_name],
    }

    file { $nrpe_systemd:
      ensure  => $ensure_package,
      backup  => true,
      content => template("nrpe/systemd.${::operatingsystem}.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => File[$systemd],
      notify  => Service[$nrpe_service_name],
    }

    service { $nrpe_service_name:
      ensure   => $ensure_service,
      enable   => $enable,
      provider => 'systemd',
      require  => [ Package[$nrpe_package_name],
                    File[$systemd],
                    File[$nrpe_systemd],
                    File[$include],
                    File[$include_dir] ],
    }
  }
  # sysvinit
  else {
    file { $nrpe_sysconfig:
      ensure  => $ensure_package,
      backup  => true,
      content => template("nrpe/sysconfig.${::operatingsystem}.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package[$nrpe_package_name],
      notify  => Service[$nrpe_service_name],
    }

    service { $nrpe_service_name:
      ensure     => $ensure_service,
      enable     => $enable,
      hasrestart => true,
      hasstatus  => true,
      require    => [ Package[$nrpe_package_name],
                      File[$nrpe_sysconfig],
                      File[$include],
                      File[$include_dir] ],
    }
  }

  file { $nrpe_config:
    ensure  => $ensure_package,
    backup  => true,
    content => template('nrpe/nrpe.cfg.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => [ File[$include], File[$include_dir] ],
    notify  => Service[$nrpe_service_name],
  }

  file { $include:
    ensure  => $ensure_package,
    backup  => true,
    content => template('nrpe/nrpe_local.cfg.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$nrpe_package_name],
    notify  => Service[$nrpe_service_name],
  }

  file { $include_dir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Package[$nrpe_package_name],
    notify  => Service[$nrpe_service_name],
  }
}
# EOF

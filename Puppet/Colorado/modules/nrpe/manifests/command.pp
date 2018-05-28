# == Class: nrpe::command
#
#
#
define nrpe::command (
  $command,
  $ensure            = present,
  $nrpe_package_name = $nrpe::nrpe_package_name,
  $nrpe_service_name = $nrpe::nrpe_service_name,
  $nrpe_plugins      = $nrpe::nrpe_plugins,
  $include_dir       = $nrpe::include_dir,
  $sudo              = false,
  $sudo_user         = 'root'
) {
  file { "${include_dir}/${title}.cfg":
    ensure  => $ensure,
    content => template('nrpe/command.cfg.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$nrpe_package_name],
    notify  => Service[$nrpe_service_name],
  }
}
# EOF

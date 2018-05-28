# == Class: nrpe::plugin
#
#
#
define nrpe::plugin (
  $ensure            = present,
  $content           = undef,
  $source            = undef,
  $nrpe_package_name = $nrpe::nrpe_packages_name,
  $nrpe_plugins      = $nrpe::nrpe_plugins,
) {
  file { "${nrpe_plugins}/${title}":
    ensure  => $ensure,
    content => $content,
    source  => $source,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Package[$nrpe_package_name],
  }
}
# EOF

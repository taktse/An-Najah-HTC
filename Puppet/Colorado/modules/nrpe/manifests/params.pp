# == Class: nrpe::params
#
# This is a container class holding default parameters for nrpe module.
#
class nrpe::params {
  $log_facility            = 'daemon'
  $server_port             = '5666'
  $server_address          = '0.0.0.0'
  $allowed_hosts           = ['127.0.0.1']
  $dont_blame_nrpe         = '0'
  $debug                   = '0'
  $command_timeout         = '60'
  $connection_timeout      = '300'

  $systemd                 = '/etc/systemd/system/nagios-nrpe-server.service.d'

  case $::operatingsystem {
    /(?i:debian|devuan|ubuntu)/: {
      $nrpe_package_name   = 'nagios-nrpe-server'
      $nrpe_package_deps   = [ 'nagios-plugins' ]
      $nrpe_service_name   = 'nagios-nrpe-server'
      $nrpe_user_name      = 'nagios'
      $nrpe_group_name     = 'nagios'
      $nrpe_sysconfig      = '/etc/default/nagios-nrpe-server'
      $nrpe_systemd        = "${systemd}/override.conf"
      $nrpe_options        = []
      $nrpe_config         = '/etc/nagios/nrpe.cfg'
      $nrpe_plugins        = '/usr/lib/nagios/plugins'
      $pid_file            = '/var/run/nagios/nrpe.pid'
      $include             = '/etc/nagios/nrpe_local.cfg'
      $include_dir         = '/etc/nagios/nrpe.d'
    }
    /(?i:fedora|redhat)/       : {
      $nrpe_package_name   = 'nrpe'
      $nrpe_package_deps   = [ 'nagios-plugins-all' ]
      $nrpe_service_name   = 'nrpe'
      $nrpe_user_name      = 'nrpe'
      $nrpe_group_name     = 'nrpe'
      $nrpe_sysconfig      = '/etc/sysconfig/nrpe'
      $nrpe_systemd        = "${systemd}/override.conf"
      $nrpe_options        = []
      $nrpe_config         = '/etc/nagios/nrpe.cfg'
      $nrpe_config_local   = '/etc/nagios/nrpe_local.cfg'
      $nrpe_plugins        = $::architecture ? {
        /x86_64/ => '/usr/lib64/nagios/plugins',
        default  => '/usr/lib/nagios/plugins',
      }
      $pid_file            = '/var/run/nrpe/nrpe.pid'
      $include             = '/etc/nagios/nrpe_local.cfg'
      $include_dir         = '/etc/nrpe.d'
    }
    /(?i:centos)/              : {
      $nrpe_package_name   = 'nrpe'
      $nrpe_package_deps   = [ 'nagios-plugins-all' ]
      $nrpe_service_name   = 'nrpe'
      $nrpe_user_name      = 'nrpe'
      $nrpe_group_name     = 'nrpe'
      $nrpe_sysconfig      = '/etc/sysconfig/nrpe'
      $nrpe_systemd        = "${systemd}/override.conf"
      $nrpe_options        = []
      $nrpe_config         = '/etc/nagios/nrpe.cfg'
      $nrpe_plugins        = $::architecture ? {
        /x86_64/ => '/usr/lib64/nagios/plugins',
        default  => '/usr/lib/nagios/plugins',
      }
      $pid_file            = '/var/run/nrpe/nrpe.pid'
      $include             = '/etc/nagios/nrpe_local.cfg'
      $include_dir         = '/etc/nrpe.d'
    }
    default                    : {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

  # plugins settings
  $check_disk_exclude_type = [ 'aufs',
                              'cgroup',
                              'cifs',
                              'debugfs',
                              'devpts',
                              'devtmpfs',
                              'hugetlbfs',
                              'nfs',
                              'nfs4',
                              'nsfs',
                              'overlay',
                              'proc',
                              'securityfs',
                              'shm',
                              'sysfs',
                              'tmpfs',
                              'tracefs',
                              'udev' ]
}
# EOF

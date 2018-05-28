# Class: iptables
# ===========================
#
# Full description of class iptables here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'iptables':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#

class iptables {

#
# If we are running >= SL7, we have to make sure firewalld is gone
# This doesn't seem to work properly after a kisckstart install on SL72
#
  if $lsbmajdistrelease != undef and $facts['lsbmajdistrelease'] >= '8' {
    package{ 'firewalld':
      ensure => absent,
    }
    service {'firewalld_stop':
      status => stop,
      enable => false,
    } 
  }

#
# Get the iptables package and configuration names from hiera
#
  $iptables = hiera('iptables::package', 'iptables-services')
  $iptables_config = hiera('iptables::config_file', 'iptables-default')

  file {'/etc/sysconfig/iptables':,
     require => Package['iptables',],
     notify  => Service['iptables',],
     ensure  => file,
     replace => true,
     owner   => 'root',
     group   => 'root',
     mode    => '0600',
     source  => "puppet:///modules/iptables/etc/sysconfig/${$iptables_config}"
  }

  package {'iptables':,
     name   => "${iptables}",
     ensure => installed,
     notify => Service['iptables',],
  }

  service {'iptables':,
     ensure => running,
     enable => true,
  }
}

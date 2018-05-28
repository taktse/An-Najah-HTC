# Class: gnome_desktop
# ===========================
#
# Full description of class gnome_desktop here.
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
#    class { 'gnome_desktop':
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
# Copyright 2018 Your name here, unless otherwise noted.
#

class gnome_desktop {

}

define gnome::desktop (
  Enum['present', 'installed', 'absent', 'purged'] $ensure  = hiera('::gnome::desktop', 'present'),
) {
  notify{'gnome_desktop': message => "Module: GNOME Desktop ($ensure)"}
  include yum
  yum::group { 'GNOME Desktop':
    ensure  => "$ensure",
    timeout => 900,
  }

  file { 'gnome_login_screen':
    path     => '/etc/dconf/db/gdm.d/00-login-screen',
    ensure   => 'present',
  } ->

  file_line { 'org_gnome_login_screen':
   path      => '/etc/dconf/db/gdm.d/00-login-screen',
   line      => '[org/gnome/login-screen]',
  } ->

  file_line { 'disable_user_list':
    path     => '/etc/dconf/db/gdm.d/00-login-screen',
    line     => 'disable-user-list=true',
    after    => '\[org/gnome/login-screen\]',
    multiple => false,
    notify   =>    Exec['dconf'],
  }

  exec {'dconf':,
    command => '/usr/bin/dconf update',
  }

  case $ensure {
    'present', 'installed', default: {
      file { "/etc/systemd/system/default.target":
        ensure => link,
        target => '/lib/systemd/system/runlevel5.target',
      }    
    }
    'absent', 'purged': {
      file { "/etc/systemd/system/default.target":
        ensure => link,
        target => '/lib/systemd/system/runlevel3.target',
      }    
    }
  }
}

# Class: motd
# ===========================
#
# Full description of class motd here.
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
#    class { 'motd':
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

#
# Install /etc/motd 
# Contains $facts that are unique to each machine
#   

class motd {
    if $kernelrelease != undef {
      $hostname     = $facts['fqdn']
      $model        = $facts['processors']['models'][0]
      $number_cores = $facts['processors']['count']
      $os           = $facts['os']['distro']['description']
      $kernel       = $facts['kernelrelease']
      $memory       = $facts['memory']['system']['total']
      $swap         = $facts['memory']['swap']['total']
      file {'/etc/motd':
        mode  => '0644',
        owner => 'root',
        group => 'root',
        content => template("motd/motd.erb"),
     }
  }
}

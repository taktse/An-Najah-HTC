# Class: nfs
# ===========================
#
# Full description of class nfs here.
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
#    class { 'nfs':
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
# TODO: Add correct package and service dependency 
#       Restart service when there are changes
#
#

class nfs {

#
# Make sure that rpc.nfsd supports all NFS protocols
#
  $nfs_config          = hiera('nfs::nfs_config', '/etc/sysconfig/nfs')
  $args_rpc_nfsd       = hiera('nfs::args_rpc_nfsd', 'RPCNFSDARGS="-N 2,3,4,4.1"')
  $args_rpc_nfsd_count = hiera('nfs::args_rpc_nfsd_count', 'RPCNFSDCOUNT=8')

  if ($facts[os][release][major] == '9' ) {

     notify{'os_major_version':, message => " OS major version is 7"}
     $nfs_package = "nfs-utils"
     $nfs_services = "rpcbind nfs-server nfs-lock nfs-idmap"

     package {"$nfs_package":
        ensure => installed,
     }

     service{"$nfs_services":,
       ensure => running,
       enable => true,
       require => Package["$nfs_package"],
     }
  }

  file_line { "nfs_config_rpc_nfsd":
      path => "${nfs_config}",
      line => "$args_rpc_nfsd",
      match   => "^RPCNFSDARGS.*$",
  }
  file_line { "nfs_config_rpc_nfsd_count":
      path => "${nfs_config}",
      line => "$args_rpc_nfsd_count",
      match   => "^RPCNFSDCOUNT.*$",
  }

}


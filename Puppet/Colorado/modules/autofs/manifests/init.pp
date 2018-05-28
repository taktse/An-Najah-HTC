# Class: autofs
# ===========================
#
# Full description of class autofs here.
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
#    class { 'autofs':
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

define install_autofs_configs (
    String $filename = $title,
    String $directory = 'etc',
    String $mode = '0644',
  ) {
      file { "/${directory}/${filename}":
         notify  => Service['autofs'],
         require => Package['autofs'],
         ensure  => file,
         replace => true,
         owner   => 'root',
         group   => 'root',
         mode    => "${mode}",
         source => "puppet:///modules/localfiles/${directory}/${filename}",
     }
  }


class autofs {

   install_autofs_configs{'auto.master':}
   install_autofs_configs{'auto.axpbase':} 
   install_autofs_configs{'auto.axpsub':}  
   install_autofs_configs{'auto.batch':}   
   install_autofs_configs{'auto.misc':}    
   install_autofs_configs{'auto.nfs':}     

   $autofs          = hiera('autofs::autofs', 'autofs')
   $rpcbind         = hiera('autofs::rpcbind', 'rpcbind')
   $nfs_utils       = hiera('autofs::nfs_utils', 'nfs-utils')
   $nfs_server      = hiera('autofs::nfs_server', 'nfs-server')
   $nfs_mountd      = hiera('autofs::nfs_mountd', 'nfs-mountd')
   $rpcbind_service = hiera('autofs::rpcbind_service', 'rpcbind')
    
   package {"${rpcbind}":
       ensure => installed,
   } 

   package {"${nfs_utils}":
       ensure => installed,
   } 

   package {"${autofs}":
       require => Package["${rpcbind}", "${nfs_utils}"],
       ensure => installed,
   } 

   if ( versioncmp($facts[os][release][major], '6') <= 0 ) {
     service {"${rpcbind_service}":
       require => Package["${rpcbind}"],
       ensure  => running,
       enable  => true,
     } 
   } else {
     service {"${rpcbind_service}":
       require => Package["${rpcbind}"],
       ensure  => running,
     } 
   }

   service {"${nfs_server}":
       require => Package["${nfs_utils}"],
       ensure => running,
       enable => true,
   } 

   service {"${nfs_mountd}":
       require => Package["${nfs_utils}"],
       ensure => running,
       enable => true,
   } 

   service {"${autofs}": 
       require => Service["${rpcbind_service}", "${nfs_server}", "${nfs_mountd}"],
       ensure => running,
       enable => true,
   }
}

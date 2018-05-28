#cvmfs/manifests/fuse.pp
#==Class==
# fyse::fuse
#
# Designed to manage the config on fuse
#=============
#
# Written by Edgar Fajardo (efajardo@physics.ucsd.edu)
# For the OSG Software team
# [*package_ensure*]
# Specifies if a package is wanted installed or latest. Only this two vaules are allowed.
#
#
class cvmfs::fuse ( )
{
      file{'fuse.conf':
        path   => '/etc/fuse.conf',
        ensure => 'present',
      }->
      file_line { 'fuse.conf_line':
        path => '/etc/fuse.conf',
        line => 'user_allow_other',
      }

      file{'auto.master':
        path   => '/etc/auto.master',
        ensure => 'present',
      }->
      file_line { 'auto.master_line':
        path => '/etc/auto.master',
        line => '/cvmfs /etc/auto.cvmfs',
      }

      service {'autofs':
        ensure    => 'running',
        enable    => true,
        subscribe => [
          File['auto.master'],
          File['fuse.conf'],
        ]
      }
      
        
        
}

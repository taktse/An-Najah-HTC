#cvmfs/manifests/init.pp
# == Class: cvmfs
#
# This module manages cvmfs
#
# == Architecture
# It is made out of two parts:
# cvmfs::install for installation and cert files
# cvmfs::config for the actual configuration
# === Parameters
#
# You should not pass parameters to this class.
# All defaults should be changed using hiera configuration files
#
# [*cvmfs_repositories*] - Defines which vmfs directories are mountable
# [*package_ensure*]     - Specifies if a package is wanted installed or latest. 
#                          Only this two vaules are allowed.
# [*cache_base_dir*]     - The directory that CVMS will install its cache
# [*quota_limit*]        - The cache limit on the node
# [*http_proxy*]         - The host and port of the http_proxy
#             
class cvmfs (
             $cvmfs_repositories,
             $cvmfs_ensure,
             $cvmfs_enable,
             $cvmfs_package,
             $cache_base_dir,
             $quota_limit,
             $http_proxy,
             $config_path,
             $config_template,
             $config_ensure,
             $fuse_config,
             $fuse_config_line,
             $auto_master,
             $auto_master_line,
             $autofs_ensure,
             $autofs_enable, 
             $cms_site_config,
             $cms_site_config_ensure,
             $cms_site_config_template,
             $cms_site_local,
             $cms_site_local_ensure,
             $cms_site_local_template,
             $cms_site,
            )
  {

#
# cvmfs needs autofs 
# wrap it in a ! defined in case it is defined somewhere else
#
      if ! defined(Service['autofs']) {
        service { 'autofs':
          ensure => "running",
          enable => true,
        }
      }

      if ! defined(Package['autofs']) {
        package { 'autofs':
          ensure => "installed",
          notify => Service['autofs'],
        }
      }
#
#------------------------------------------------------------------
#
#
        package{'cvmfs':
          ensure => "${cvmfs_ensure}",
          name   => "${cvmfs_package}",
          notify => Service['autofs'],
        }
  
#
#------------------------------------------------------------------
#
#
       file {'default.local':
          path   => "${config_path}",
          ensure => "${config_ensure}",
          content => template("${config_template}"),
          notify => Service['autofs'],
       }

#
#------------------------------------------------------------------
#
#
       file {'cms.cern.ch.conf':
          path   => "${cms_site_config}",
          ensure => "${cms_site_config_ensure}",
          content => template("${cms_site_config_template}"),
          notify => Service['autofs'],
       }

#
#------------------------------------------------------------------
#
#
       file {'cms.cern.ch.local':
          path   => "${cms_site_local}",
          ensure => "${cms_site_local_ensure}",
          content => template("${cms_site_local_template}"),
          notify => Service['autofs'],
       }

#
#------------------------------------------------------------------
#
#
      
      file_line { 'cvmfs_fuse.conf_line':
        path => "${fuse_config}",
        line => "${fuse_config_line}",
        notify => Service['autofs'],
      }


}



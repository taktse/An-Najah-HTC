# Class: local_defs
# ===========================
#
# Full description of class local_defs here.
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
#    class { 'local_defs':
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
#
# Install a configuration file
#
define install_config_file (
    String $source_file = hiera("\"${caller_module_name}::config::$name\"", "$title"),
    String $dest_file   = $title,
    String $directory = 'etc',
    String $mode = '0644',
  ) {
     if $source_file != 'undefined' {
       file { "/${directory}/${dest_file}":
         ensure  => file,
         replace => true,
         owner   => 'root',
         group   => 'root',
         mode    => "${mode}",
         source => "puppet:///modules/${caller_module_name}/${directory}/${source_file}",
       }
     }
  }

#
# Create a symbolic link
#
define create_symlink (
  String $from,
  String $to,
 ) {
     if $from != 'undefined' {
       $link_from = hiera("\"${caller_module_name}::symlink::$title\"",     "$from")
       $link_to   = hiera("\"${caller_module_name}::symlink_to::$title\"",  "$to")
       file { "$link_from":
         ensure => link,
         target => "$link_to",
       }    
   }
}

#
# Create a directory
#
define create_directory (
   String $directory = hiera("\"${caller_module_name}::directory::$name\"", "$title"),
   String $owner = 'root',
   String $group = 'root',
   String $mode  = '0755',
 ) {
     if $directory != 'undefined' {
       file { "$directory":
         ensure => directory,
         owner  => "${owner}",
         group  => "${group}",
         mode   => "${mode}",
       }
   }
}

define cuhep_package_installation {
    $packages = hiera("pkg_group::$name", "$name")
    if $packages.is_a(Array) {
       each($packages) |$package| {
          $pkg_name = hiera("pkg_group::$package", "$package")
          if $pkg_name != 'undefined' {
             package {"$pkg_name":
               ensure => installed,
             }
          }
       }
    } else {
      $pkg_name = hiera("pkg_group::$name", "$name")
      if $pkg_name != 'undefined' {
         package {"$pkg_name":
            ensure => installed,
         }
      }
    }
}


class local_defs {


}

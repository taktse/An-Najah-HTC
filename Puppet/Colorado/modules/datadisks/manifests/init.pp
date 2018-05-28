# Class: datadisks
# ===========================
#
# Full description of class datadisks here.
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
#    class { 'datadisks':
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
class datadisks {
   $datadisks = hiera_array('datadisks:', "undefined")

   install_config_file { 'RunGetSMARTResultsRAID':,   mode => '0755', directory => "etc/cron.daily",}
   cuhep_package_installation{'3ware-tools':}

   if $datadisks.is_a(Array) {
      each($datadisks) |$datadisk| {
#        notice "$datadisk datadisk value"
#        notify {"$datadisk": message => "$datadisk datadisk value" }
      }
   }

   if $datadisks.is_a(Array) {
      each($datadisks) |$datadisk| {
         if $datadisk != 'undefined' {
           $mountpoint   = hiera("\"datadisks::${datadisk}::mount\"", "#")
           $label        = hiera("\"datadisks::${datadisk}::label\"")
           $export       = hiera("\"datadisks::${datadisk}::export\"", "@allhosts(rw,async,no_root_squash)")
           $type         = hiera("\"datadisks::${datadisk}::type\"",   "ext4")
           $export_options = '@allhosts(rw,async,no_root_squash)'
           file_line { "fstab_$datadisk":
              path => '/etc/fstab',
              line => "LABEL=${label}    ${mountpoint}   ${type}   defaults  1 4",
              match   => "^LABEL=${label}.*$",
           }
           file_line { "exports_$datadisk":
              path => '/etc/exports',
              line => "${mountpoint}   ${export}",
              match   => "^${mountpoint}.*$",
           }
           exec { "Create ${mountpoint}":
              creates => $mountpoint,
              command => "mkdir -p ${mountpoint}",
              path => $::path
           } -> file { $mountpoint:}
        }
      }
   } else {
      $datadisk = hiera("datadisks:", "undefined")
      if $datadisk != 'undefined' {
         $mountpoint   = hiera("\"datadisks::${datadisk}::mount\"", "#")
         $label        = hiera("\"datadisks::${datadisk}::label\"")
         $export       = hiera("\"datadisks::${datadisk}::export\"", "@allhosts")
         $type         = hiera("\"datadisks::${datadisk}::type\"",   "ext4")
         file_line { 'fstab':
            path => '/etc/fstab',
            line => "LABEL=${label}     ${mountpoint}   ${type}      defaults    1 4",
         }
         file_line { 'exports':
            path => '/etc/exports',
            line => "${mountpoint}   @allhosts(rw,async,no_root_squash)",
         }
         exec { "Create ${mountpoint}":
            creates => $mountpoint,
            command => "mkdir -p ${mountpoint}",
            path => $::path
         } -> file { $mountpoint:}
      }
   }
}


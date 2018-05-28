
# ===========================
#
# Full description of class common_services here.
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
#    class { 'common_services':
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
#-----------------------------------------------------------
# Definition for the configuration file
#         
define common_service_configfile (
    String $filename = hiera("\"${title}\"", "$title"),
    String $directory = 'etc',
    String $mode = '0644',
    String $owner = 'root',
    String $group = 'root',
    String $package,
  ) {
      file { "/${directory}/${title}":
         ensure  => file,
         replace => true,
         owner   => "${owner}",
         group   => "${group}",
         mode    => "${mode}",
         source  => "puppet:///modules/${caller_module_name}/${directory}/${filename}",
         require => Package["$package"],
         notify  => Service["$package"],
     }
  }


#-----------------------------------------------------------
# Definition for the service 
#
define common_service_installation {
    package {"$name":
       ensure => installed,
    }
}

#------------------------------------------------------------
# Definition for the state of the service
#
define common_service_status (
  String $file,
  ) {
    service {"$name":
       ensure => "running",
       enable => true,
       require => File[$file],
    }
  }


#------------------------------------------------------------
# Combine the above definitions into a single definition
#
define common_service_control (
    String $directory,
    String $file,
  ) {
      common_service_installation{ "$name": }
      common_service_configfile{ "$file":, package => "$name", directory => "$directory"}
      common_service_status{ "$name":, file => "/${directory}/${file}" }
 }

#-------------------------------------------------------------
# Began the actions for this class
#
class common_services {

   common_service_control{'sendmail':, file => 'sendmail.cf', directory => 'etc/mail'}
   common_service_control{'ypbind':,   file => 'yp.conf',     directory => 'etc'}
   common_service_installation{'rsh_server':, name => "rsh-server", }

}

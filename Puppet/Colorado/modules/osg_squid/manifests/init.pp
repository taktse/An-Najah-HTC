# Class: osg_squid
# ===========================
#
# Full description of class osg_squid here.
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
#    class { 'osg_squid':
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
class osg_squid {

   common_service_installation{'frontier-squid':} 
   create_directory    { "/opt/squid/data":              owner => 'squid',  group => 'squid',  mode => '0755',}
   create_directory    { "/opt/squid/data/squid_cache":  owner => 'squid',  group => 'squid',  mode => '0755',}
   create_directory    { "/opt/squid/log":               owner => 'daemon', group => 'squid',  mode => '0775',}
   common_service_configfile{"customize.sh":             owner => 'squid',  group => 'squid',  mode => '0775', package => "frontier-squid", directory => 'etc/squid'}
   common_service_status{ "frontier-squid":, file => "/etc/squid/customize.sh",}

}

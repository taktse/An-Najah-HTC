	# Class: role
# ===========================
#
# Full description of class role here.
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
#    class { 'role':
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
class role {
    notify{'role':, message => "Class: role"}
    include profile::base
}

#
# Worker node profiles
#
class role::htcxxx inherits role {
    notice("Configuration for generic worker node")
    include profile::htcxxx
}

#
#  Server profiles
#
class role::server inherits role {
    include profile::base
}

class role::server::www inherits role::server {
    notice("Configuration for the www server")
    include profile::www
}

class role::server::puppet {
    notice("Configuration for the puppet server")
    include profile::puppet
}

class role::server::cobbler inherits role::server {
    notice("Configuration for the cobbler server")
    include profile::cobbler
}

class role::server::login inherits role::server {
    notice("Configuration for the login server")
    include profile::login
}

class role::server::htc180 inherits role::server {
    notice("Configuration for the htc180 server")
    include profile::htc180
}

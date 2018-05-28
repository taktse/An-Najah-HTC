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
    notify{'role_message':, message => "Class: role"}
    include profile::base
}

#
# Worker node profiles
#
class role::htcxxx inherits role {
    notify{'role::htcxxx':, message => "Configuration for generic worker node"}
    include profile::htcxxx
}

#
#  Server profiles
#
class role::server inherits role {
    notify{'role::server':, message => "Configuration for server node"}
    include profile::base
}

class role::server::www inherits role::server {
    notify{'role::www':, message => "Configuration for www node"}
    include profile::www
}

class role::server::puppet {
    notify{'role::puppet':, message => "Configuration for puppet node"}
    include profile::puppet
}

class role::server::cobbler inherits role::server {
    notify{'role::cobbler':, message => "Configuration for cobbler node"}
    include profile::cobbler
}

class role::server::login inherits role::server {
    notify{'role::login':, message => "Configuration for login node"}
    include profile::login
}

class role::server::htc180 inherits role::server {
    notify{'role::htc180':, message => "Configuration for central server node"}
    include profile::htc180
}

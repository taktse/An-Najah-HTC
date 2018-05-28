# Class: profile
# ===========================
#
# Full description of class profile here.
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
#    class { 'profile':
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
class profile {
    notify{"profile": message => "Profile profile class"}
    notice("Profile class")
#    include local_defs
#    include stdlib
}

class profile::base inherits profile {
    notify{"profile::base": message => "Profile profile::base class"}
    notice("Profile base class")
#    include common_packages
#    include common_services
#    include localfiles
#    include autofs
#    include iptables
#    include ntp
#    include nfs
    include motd
}

#
# Standard Worker node
# Inherits all the properties from profile::base
#
class profile::htcxxx  inherits profile::base {
    notify{"profile::cms": message => "Profile profile::htcxxx class"}
}


#
# WWW
# Inherits all the properties from profile::base
#
class profile::www  inherits profile::base {
    notify{"profile::www": message => "Profile profile::www class"}
}

#
# Puppet
# Inherits all the properties from profile::base
#
class profile::puppet  inherits profile::base {
    notify{"profile::puppet": message => "Profile profile::puppet class"}
}
#
# Cobbler
# Inherits all the properties from profile::base
#
class profile::cobbler  inherits profile::base {
    notify{"profile::cobbler": message => "Profile profile::cobbler class"}
}
#
# Login
# Inherits all the properties from profile::base
#
class profile::login  inherits profile::base {
    notify{"profile::login": message => "Profile profile::login class"}
}

#
# htc180
# Inherits all the properties from profile::base
#
class profile::htc180  inherits profile::base {
    notify{"profile::htc180": message => "Profile profile::htc180 class"}
}


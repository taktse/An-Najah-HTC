# Class: network_manager
# ===========================
#
# Full description of class network_manager here.
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
#    class { 'network_manager':
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
class network_manager {

#
# This is a kludge since I don't know how to remove a package and its dependencies
# The parameter uninstall_options doesn't seem to work as of puppet 4.10.1
#
# NetworkManager-duh is inserted to show that this will work for other OSs (Ubuntu) by simply adding the correct name(s)
#
# This should be fixed   package{ 'network_manager_pkg_team': name => 'NetworkManager-team', uninstall_options => ['--nodeps',], ensure => absent, } ->
# This should be fixed   package{ 'network_manager_pkg_tui':  name => 'NetworkManager-tui',  uninstall_options => ['--nodeps',], ensure => absent, } ->
# This should be fixed   package{ 'network_manager_pkg_wifi': name => 'NetworkManager-wifi', uninstall_options => ['--nodeps',], ensure => absent, } ->
# This should be fixed   package{ 'network_manager_pkg_duh':  name => 'NetworkManager-duh',  uninstall_options => ['--nodeps',], ensure => absent, } ->
# This should be fixed   package{ 'network_manager_pkg':      name => 'NetworkManager',      uninstall_options => ['--nodeps',], ensure => absent, }

}

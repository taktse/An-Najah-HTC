# Class: common_packages
# ===========================
#
# Full description of class common_packages here.
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
#    class { 'common_packages':
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


class common_packages {

    cuhep_package_installation{'yum-priorities':}
#     cuhep_package_installation{'alpine':}
    cuhep_package_installation{'augeas':}
    cuhep_package_installation{'augeas-libs':}
    cuhep_package_installation{'augeas-devel':}
    cuhep_package_installation{'bind-utils':}
    cuhep_package_installation{'python-augeas':}
    cuhep_package_installation{'createrepo':}
    cuhep_package_installation{'dump':}
    cuhep_package_installation{'emacs':}
    cuhep_package_installation{'expect':}
    cuhep_package_installation{'git':}
    cuhep_package_installation{'lftp':}
    cuhep_package_installation{'lsb':}
    cuhep_package_installation{'lsof':}
    cuhep_package_installation{'lm_sensors':}
    cuhep_package_installation{'man-pages':}
    cuhep_package_installation{'man-db':}
    cuhep_package_installation{'mutt':}
    cuhep_package_installation{'nano':}
    cuhep_package_installation{'nmap':}
    cuhep_package_installation{'perl':}
    cuhep_package_installation{'python':}
    cuhep_package_installation{'rsh':}
    cuhep_package_installation{'ruby':}
    cuhep_package_installation{'strace':}
    cuhep_package_installation{'smartmontools':}
    cuhep_package_installation{'tcsh':}
    cuhep_package_installation{'sysstat':}
    cuhep_package_installation{'telnet':}
    cuhep_package_installation{'traceroute':}
    cuhep_package_installation{'tmpwatch':}
    cuhep_package_installation{'xfsdump':}
    cuhep_package_installation{'vim':}
}

class common_packages::with_configs {

#    common_package_install_with_configs{'ypbind':, config => "/etc/yp.conf"}
    common_package_install_with_configs{'rsh-server':, config => "/etc/securetty"}      # securetty might be OS dependent
    common_package_install_with_configs{'ypbind':, config => "/etc/yp.conf"}
    common_package_install_with_configs{'openafs':, config => "/etc/vice/ThisCell"}
    common_package_install_with_configs{'sendmail':, config => "/etc/mail/sendmail.cf"} # Need hiera lookup for sendmail.cf
    common_package_install_with_configs{'authfs':, configs => "autofs_configs"}         # Need hiera lookup for /etc/auto.*
    
}


# cvmfs/manifests/install.pp
# == Class: cvmfs::install ===========================
#
# This module manages cvmfs installation and auxilary software
# ===========================================
# Developed by Edgar Fajardo
# on behalf of OSG Software
# == Architecture ======================
#
# === Parameters =========================
#
#
# [*package_ensure*]
# Specifies if a package is wanted installed or latest. Only this two vaules are allowed.
#
#
class cvmfs::install (
    $package_ensure = "installed",
    )
{
    include osg_repos
    include selinux
  
    package{ 'osg-oasis':
           ensure   => $package_ensure,
           provider => 'yum',
           name     => "osg-oasis"
         }
    


}

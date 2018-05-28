
#--------------------------------------------------------------------------
#
# Main install class
# etc/sysctl.d/90-cuhep-no-ipv6.conf
# etc/netconfig
# etc/ssh/sshd_config
#--------------------------------------------------------------------------

class localfiles::install inherits localfiles {

 install_config_file { 'hosts': }
 install_config_file { 'hosts.equiv': }
 install_config_file { 'nsswitch.conf': }
 install_config_file { 'resolv.conf': }
 install_config_file { 'csh.cshrc': }
 install_config_file { 'csh.login': }
 install_config_file { 'netconfig': }
 install_config_file { 'CUStuff.sh':            directory => "etc/profile.d",}
 install_config_file { 'CUStuff.csh':           directory => "etc/profile.d",}
 install_config_file { 'shosts.equiv':          directory => "etc/ssh",}
 install_config_file { 'ssh_known_hosts':       directory => "etc/ssh",}
 install_config_file { 'sshd_config':           directory => "etc/ssh", mode => '0600',} 
 install_config_file { '90-cuhep-no-ipv6.conf': directory => "etc/sysctl.d", mode => '0644',} 
 create_directory    { "/root/.emacs.d":        mode => '0775',}
 install_config_file { '.emacs':                directory => "root",}
 install_config_file { 'puppet-mode.el':        directory => "root/.emacs.d",}
 install_config_file { '.bash_profile':         directory => "root",}
 install_config_file { '.cshrc':                directory => "root",}
 install_config_file { '.login':                directory => "root",}
 install_config_file { 'authorized_keys':       directory => "root/.ssh", mode => '0600',} 

 install_config_file { 'cuhep-cron-hourly':,    mode => '0755', directory => "etc/cron.hourly",}
 install_config_file { 'CleanBatchSpace':,      mode => '0755', directory => "etc/cron.daily",}
 install_config_file { 'RecordUptime':,         mode => '0755', directory => "etc/cron.daily",}
 install_config_file { 'RunGetSMARTResults':,   mode => '0755', directory => "etc/cron.daily",}
 install_config_file { 'sudoers':,              mode => '0440', directory => "etc",}

 create_symlink{ 'com-stat':,        from => '/com-stat',       to => "/nfs/heplocal/WWW/html/computing/ClusterStatus",}
 create_symlink{ 'sge-batch':,       from => '/sge-batch',      to => "/batch/${facts['hostname']}",}
 create_symlink{ 'usr_local':,       from => '/usr/local',      to => "/misc/local",}
 create_symlink{ 'usr_users':  ,     from => '/usr/users',      to => "/nfs/hepusers/users",}
 create_symlink{ 'usr_users02':,     from => '/usr/users02',    to => "/nfs/hepusers/users02",}
 create_symlink{ 'usr_adm':,         from => '/usr/adm',        to => '/var/log',}
 create_symlink{ 'usr_spool':,       from => '/usr/spool',      to => '/var/spool',}
 create_symlink{ 'var_spool_mail':,  from => '/var/spool/mail', to => '/misc/mail',}

#-------------------------------------------------------------------------------------------
# Create the batch area directory. This should only matter for machines
# without dedicated partitions. It is historical that the directory is:
#  /amd/batch/$hostname/batch 
# This was the mount point when we used the amd automounter and it is
# used in the auto.batch map file.
# WARNING: On systems without a dedicated partition this is probably on /
#
 create_directory { "/amd":, mode => '0775',}
 create_directory { "/amd/${facts['hostname']}":, mode => '0775',}
 create_directory { "/amd/${facts['hostname']}/batch":, mode => '0775',}
 create_directory { "/amd/${facts['hostname']}/batch/${facts['hostname']}":, mode => '1777',}
 file_line { 'exports_batch':
    path => '/etc/exports',
    line => "/amd/${facts['hostname']}/batch/${facts['hostname']}   @allhosts(rw,async,no_root_squash)",
    match => "^/amd/${facts['hostname']}/batch/${facts['hostname']}.*$",
 }

#-------------------------------------------------------------------------------------------

#
#  Append some lines to /etc/securetty so that rsh/rlogin will work for root without a password
#  Note: At some point this should be removed when these clients are no longer need to manage the system
#
 file_line { 'securetty_rsh':
   path => '/etc/securetty',
   line => 'rsh',
 }
 file_line { 'securetty_rlogin':
   path => '/etc/securetty',
   line => 'rlogin',
 }

}

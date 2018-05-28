
setenv HOST `hostname | sed 's/\..*//'`
setenv LANG C


# unlimit 
limit coredumpsize 0

#   Check to see if this is batch job
#
if ($?JOB_NAME || $?PBS_ENVIRONMENT) then
    echo "DQS Spooled Job"
    exit 0
endif

#
#    If we are not interactive, we skip the rest of the stuff
#
if ($?prompt) then
        if($?TERM && $TERM =~ vt100) then
           stty erase 
        endif

       set history = 250 savehist=250
       set path = ( $HOME/bin /usr/local/adm/bin $path /opt/phedex/bin)
       setenv PAGER "less -eMs -j20"
       set noclobber
       setenv CSHEDIT emacs
       setenv EDITOR  heave
       setenv PRINTER hpiv01
       setenv MAIL /usr/spool/mail/$USER
       set    mail = $MAIL


#------------------------------------------------------------------------
#     Do a number of things with the prompt
#
        alias  set_prompt 'set prompt = "'${HOST}':${cwd}> "'
        set prompt = "root> "
        if (${term} =~ xterm* ) then
                alias cd 'chdir \!* ;echo -n "]0;"${HOST}":$cwd"'
                echo -n "]0;"${HOST}":$cwd"
        endif
        touch ~/admin/logins.log
	if($?REMOTEHOST) then 
	   set date = `date`
           echo " $date $USER from $REMOTEHOST" >> ~/admin/logins.log
        endif

#
# Set cdpath
#
         set cdpath = (  /nfs/localsrc  /usr/local/adm/src  \
                         /usr/local /usr/local/src          \
                      )
#
#------------------------------------------------------------------------
#    Define some tcsh completions
        complete cd    'p/1/d/'
        complete rmdir 'p/1/d/'
	set correct = cmd
#-----------------------------------------------------------------------
#      Aliases
#
     if(-e ~drjohn/.csh_aliases) then
        source ~drjohn/.csh_aliases
     endif
     alias cp "cp -i"
     alias mv "mv -i"
     alias rm "rm -i"
     alias heave /usr/users/drjohn/bin/heave
     alias di  "ls -alF"
     alias dir "ls -aF"
endif

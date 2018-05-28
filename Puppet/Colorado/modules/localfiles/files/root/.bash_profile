# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=/opt/puppetlabs/bin:$HOME/bin:/usr/bin:/usr/sbin:/bin:${PATH:-/usr/bin}:/usr/local/bin
export PATH

PS1="`whoami`> "
alias di="ls -alF"
alias dir="ls -aF"
alias cp="cp -i"
alias rm="rm -i"
alias heave="emacs -nw"
alias more="less -eM -j15"
MAIL=/usr/spool/mail/$USER
export PAGER="less -eM -j15"

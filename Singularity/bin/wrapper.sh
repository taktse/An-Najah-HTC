#!/bin/bash
#------------------------------------------------------------==ADM==
# Custom Software, Developed for CUHEP by staff.
# This software is in the public domain, furnished "as is", without
# technical support, and with no warranty, express or implied, as
# to its usefulness for any purpose.
#
# wrapper.sh      
#
# REVISION HISTORY
# Created.                                  12/11/2017  doug johnson
#-------------------------------------------------------------------

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-/usr/bin}:/usr/local/bin
export PATH

echo $*
exec $*

exit

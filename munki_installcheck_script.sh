#!/bin/sh

# The Domain we're supposed to be on
DOMAIN="yourorg.com"

# A valid user in AD
ADUSER="useraccount"

# The domain from dsconfigad
ACTUAL_DOMAIN=`/usr/sbin/dsconfigad -show | /usr/bin/grep -i "Active Directory Domain" | /usr/bin/sed -n 's/[^.]*= //p'`

# Is the user in AD?
ADUSER_RECOGNIZED=$(/usr/bin/id ${ADUSER} > /dev/null)$?

if [ "$ACTUAL_DOMAIN" = "$DOMAIN" ]
    then
	  	if [ "$ADUSER_RECOGNIZED" -eq 0 ]
    	then
        	# Everything's ok, no need to install
        	exit 1
   	    else
	    	exit 0
        fi
else
    # Domain isn't being returned from dsconfigad, need to install
    exit 0
fi
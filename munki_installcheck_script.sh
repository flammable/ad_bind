#!/bin/bash

dsconfigad="/usr/sbin/dsconfigad"
echo="/bin/echo"
grep="/usr/bin/grep"
id="/usr/bin/id"
nc="/usr/bin/nc"
sed="/usr/bin/sed"

# The Domain we're supposed to be on
domain="yourorg.com"

# A valid user in AD
aduser="useraccount"

# Is the AD server reachable?
ad_server_check=$(${nc} -G 3 -z ${domain} 389 &> /dev/null)$?

# The domain from dsconfigad
actual_domain=$(${dsconfigad} -show | ${grep} -i "Active Directory Domain" | ${sed} -n 's/[^.]*= //p')

# Is the user in AD?
aduser_recognized=$(${id} ${aduser} > /dev/null)$?

if [[ "${ad_server_check}" -eq 1 ]]; then
	${echo} "AD server is unreachable"
	exit 1
fi

if [[ "${actual_domain}" != "${domain}" ]]; then
	${echo} "Bound domain doesn't match AD domain"
	exit 0
fi

if [[ "${aduser_recognized}" -eq 1 ]]; then
	${echo} "AD user check failed"
	exit 0
fi

exit 1

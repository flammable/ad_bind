#!/bin/bash

dsconfigad="/usr/sbin/dsconfigad"
echo="/bin/echo"
grep="/usr/bin/grep"
id="/usr/bin/id"
nc="/usr/bin/nc"
profiles="/usr/bin/profiles"
sed="/usr/bin/sed"
sleep="/bin/sleep"

# The Domain we're supposed to be on
domain="ad.your.org"

# Is the AD server reachable?
ad_server_check=$(${nc} -G 3 -z ${domain} 389 &> /dev/null)$?

if [[ "${ad_server_check}" -eq 1 ]]; then
 ${echo} "AD server is unreachable"
 exit 1
fi

# Add a delay, so the labs don't get caught in a binding loop
${sleep} 10

bootstrap_file="/Users/Shared/.com.googlecode.munki.checkandinstallatstartup"

# Add additional 10 second delay if bootstrapping
if [ -e ${bootstrap_file} ]; then
 ${sleep} 10
fi

# The domain from dsconfigad
actual_domain=$(${dsconfigad} -show | ${grep} -i "Active Directory Domain" | ${sed} -n 's/[^.]*= //p')

if [[ "${actual_domain}" != "${domain}" ]]; then
 ${echo} "Bound domain doesn't match AD domain"
 exit 0
fi

# A valid user in AD
aduser="serviceaccount"

# Is the user in AD?
aduser_recognized=$(${id} ${aduser} > /dev/null)$?

if [[ "${aduser_recognized}" -eq 1 ]]; then
 ${echo} "AD user check failed"
 exit 0
fi

exit 1

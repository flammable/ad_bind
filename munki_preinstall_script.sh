#!/bin/bash

awk="/usr/bin/awk"
defaults="/usr/bin/defaults"
dsconfigad="/usr/sbin/dsconfigad"
networksetup="/usr/sbin/networksetup"
profiles="/usr/bin/profiles"
systemsetup="/usr/sbin/systemsetup"

bootstrap_file="/Users/Shared/.com.googlecode.munki.checkandinstallatstartup"

ADMIN_LOGIN="foo"
ADMIN_PWD="bar"

# if we're not bootstrapping, set the time
if [ ! -e ${bootstrap_file} ]; then

# set the time zone
${defaults} write /Library/Preferences/com.apple.timezone.auto Active -bool NO
${systemsetup} -settimezone "America/New_York"

${systemsetup} -setusingnetworktime off
${systemsetup} -setnetworktimeserver "time.apple.com"
${systemsetup} -setusingnetworktime on

# autoconfig
# wireless_nic=$(${networksetup} -listallhardwareports | ${awk} '$3=="Wi-Fi" {getline; print $2}')
# ${networksetup} -setairportpower $wireless_nic on
# ${defaults} write /Library/Preferences/com.apple.timezone.auto Active -bool YES

fi

# remove configuration profile, if it exists
${profiles} -R -p com.yourorg.profile.ad_bind

# forcibly remove from AD
${dsconfigad} -remove -username "${ADMIN_LOGIN}" -password "${ADMIN_PWD}" 2>&1
${dsconfigad} -force -remove -u "${ADMIN_LOGIN}" -p "${ADMIN_PWD}" 2>&1

exit 0

#!/bin/bash

dsconfigad="/usr/sbin/dsconfigad"
profiles="/usr/bin/profiles"

ADMIN_LOGIN="foo"
ADMIN_PWD="bar"

# remove configuration profile, if it exists
${profiles} -R -p com.yourorg.profile.ad_bind

# forcibly remove from AD
${dsconfigad} -remove -username "${ADMIN_LOGIN}" -password "${ADMIN_PWD}" 2>&1
${dsconfigad} -force -remove -u "${ADMIN_LOGIN}" -p "${ADMIN_PWD}" 2>&1

exit 0

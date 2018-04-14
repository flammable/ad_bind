#!/bin/bash

munkiimport="/usr/local/munki/munkiimport"

${munkiimport} \
--nointeractive \
--subdirectory scripts \
--name "ad_bind" \
--displayname "Active Directory Binding" \
--description "Binds this computer to Active Directory. This is what allows you to login to your computer. Please connect your computer to Ethernet to ensure the installation is successful." \
--pkgvers "1.0" \
--category "Scripts" \
--developer "Your Organization" \
--minimum_os_version "10.9" \
--RestartAction "RequireRestart" \
--installcheck_script ./munki_installcheck_script.sh \
--preinstall_script ./munki_preinstall_script.sh \
--uninstall_script="./munki_uninstall_script.sh" \
./ActiveDirectory.mobileconfig

exit

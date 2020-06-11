#!/bin/bash

# Binaries
basename="/usr/bin/basename"
codesign="/usr/bin/codesign"
munkiimport="/usr/local/munki/munkiimport"
munkipkg="/usr/local/munki-pkg/munkipkg"
PlistBuddy="/usr/libexec/PlistBuddy"
rm="/bin/rm"
xattr="/usr/bin/xattr"

# Determine variables to make this script more generic
pkg_name="$(${basename} ${PWD})"
pkg_version="$(${PlistBuddy} -c 'print version' ./build-info.plist)"

# This is the cert we're using to sign files for TCC
signing_cert="Developer ID Application: Your Org (ABCDEFGHIJ)"

# Array of files we're signing
# files_to_sign=('./payload/usr/local/outset/login-once/set_background_v2.sh')

# Remove extended attributes, then sign files for TCC
# for i in "${files_to_sign[@]}"
# do
#    ${xattr} -cr "$i"
#    ${codesign} -s "${signing_cert}" -i org.your.${pkg_name} "$i"
# done

# Delete stray .DS_Store file in /payload
# This fixes the error: The operation couldn’t be completed. Can't find "." in bom file
if [[ -e ./payload/.DS_Store ]]; then
 ${rm} ./payload/.DS_Store
fi

# Build the pkg
# Normally, we'd run `${munkipkg} .` but instead we're exporting Bom info to Bom.txt for Git tracking of permissions
# If building this package after running `git clone`, be sure to run `${munkipkg} --sync .` first
${munkipkg} --export-bom-info .

# Import the pkg into Munki
${munkiimport} \
--nointeractive \
--subdirectory scripts \
--name "${pkg_name}" \
--displayname "Active Directory Binding" \
--description "Binds this computer to Active Directory. This is what allows you to login to your computer. Please connect your computer to Ethernet to ensure the installation is successful." \
--category "Scripts" \
--developer "Your Org" \
--minimum_os_version "10.5.0" \
--RestartAction "RequireRestart" \
--installcheck_script ./munki_installcheck_script.sh \
--postinstall_script ./munki_postinstall_script.sh \
--uninstall_script="./munki_uninstall_script.sh" \
./build/"${pkg_name}"-"${pkg_version}".pkg

exit

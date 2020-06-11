#!/bin/bash

chown="/usr/sbin/chown"

# modified from:
# https://serverfault.com/questions/440461/script-to-run-chown-on-all-folders-and-setting-the-owner-as-the-folder-name-minu

for dir in /Users/*/; do
 # strip trailing slash
 homedir="${dir%/}"
 # strip all chars up to and including the last slash
 username="${homedir##*/}"

 ${chown} -R "${username}":staff "$dir"
done

exit 0

#!/usr/bin/env sh
output=`/lib/ufw/ufw-init status`
ret=$?
echo $output
exit $ret

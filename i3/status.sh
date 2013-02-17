#!/bin/sh

i3status -c ~/.i3/status.conf | while :
do
    read line
    mem=`free -t -m | grep "Total" | tail -n 1 | awk '{ print ""$3"MB"; }'`
    echo "$mem | $line" || exit 1
done

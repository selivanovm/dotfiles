#!/bin/bash

DATE_FORMAT="%A, %d/%m/%Y %H:%M:%S"

fdate() {
	date "+$DATE_FORMAT"
}

while true; do
	PDATE=$(fdate)

	echo "$PDATE"

	sleep 1
done

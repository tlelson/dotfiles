#!/usr/bin/env bash

while ! eval "$@"; do
	echo "unsuccessfully ran: $@"
	sleep 1
	echo "trying again ..."
done

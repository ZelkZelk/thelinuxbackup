#!/bin/bash

function error {
	message $1
	$CAT $1 | $MAIL -s "$2" $3
}

STACK=()

function message {
	STACK+=("$1\n")
	echo "[INFO] $1"
}

function summary {
	BODY=""

	for TXT in "${STACK[@]}"
	do
		BODY+="$TXT"
	done

	echo -ne "$BODY" | $MAIL -s "$1" $2
}

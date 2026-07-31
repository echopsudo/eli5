#!/bin/bash


COMMAND=$1

ELI5_HEADER() {
	echo ""
	echo "Explain I'm Like 5!, This is just man for people with ADHD"
	echo ""
}

LIST_ENTRIES() {
	echo "====== ENTRIES ======="
	echo ""
	ls eli5pages/
}

READ() {
	if [[ $COMMAND == "-l" || $COMMAND == "--list" ]]; then
		READ=$(echo "list_mode")
	else
		echo ""
		READ=$(cat eli5pages/$COMMAND 2>/dev/null)
		echo ""
	fi
}

READER() {
	READ
	if [[ $READ == "" ]]; then
		echo "No eli5 entry for the specified command!"
		echo "You could try eli5 $COMMAND if you think the entry exists on eli5 repos."
	elif [[ $READ == "list_mode" ]]; then
		LIST_ENTRIES
	else
		echo $READ
		echo ""
	fi
}

#ENTRY_INSTALLER() {
#}

READER

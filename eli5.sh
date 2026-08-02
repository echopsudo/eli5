#!/bin/bash


COMMAND=$1


ELI5_HEADER() {
	echo "ABOUT"
	echo " Explain I'm Like 5!, This is just man for people with ADHD. This was created because --help sometimes was too shallow, while the man page doesn't get to the point. Created by echopsudo on github. Enjoy!"
	echo "USAGE"
	echo " Get started with 'eli5 [COMMAND]' to see quick useful info about that command."
	echo "EXAMPLES"
	echo " 'eli5 cat', this shows information about the command 'cat'"
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
	elif [[ $COMMAND == "-h" || $COMMAND == "--help" ]]; then
		READ=$(echo "help_mode")
	elif [[ $COMMAND == "" || $COMMAND == "--about" ]]; then
		READ=$(echo "about_mode")
	else
		echo "====== $COMMAND ======="
		READ=$(cat eli5pages/$COMMAND 2>/dev/null)
		echo ""
	fi
}

WARNING() {
	CHECK=$(which $COMMAND 2>/dev/null)
	if [[ $CHECK == "" ]]; then
		echo "! Entry Exists but command does not !"
		echo ""
	fi
}
BRIEF() {
	echo "DESCRIPTION:"
	echo "$READ" | awk -v RS='~' 'NR==1'
	echo ""
}

FUNCTIONS() {
	echo "USAGE:"
	echo "$READ" | awk -v RS='~' 'NR==2'
	echo ""
}

EXAMPLES() {
	echo "EXAMPLES:"
	echo "$READ" | awk -v RS='~' 'NR==3'
	echo ""
}

HELP() {
	echo "ELI5 - helper"
	echo ""
	echo "FLAGS:"
	echo "-h or --help - displays help"
	echo "-l or --list - displays list"
	echo ""
	echo "EXAMPLES:"
	echo "eli5 --help (displays help)"
	echo "eli5 --list (displays list)"
}
READER() {
	READ
	if [[ $READ == "" ]]; then
		echo "No eli5 entry for the specified command!"
		#echo "You could try eli5 install $COMMAND if you think the entry exists on eli5 repos."
	elif [[ $READ == "list_mode" ]]; then
		LIST_ENTRIES
	elif [[ $READ == "help_mode" ]]; then
		HELP
	elif [[ $READ == "about_mode" ]]; then
		ELI5_HEADER
	else
		WARNING
		BRIEF
		FUNCTIONS
		EXAMPLES
	fi
}

#ENTRY_INSTALLER() {
#}

READER

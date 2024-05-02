#!/bin/bash

# color codes
BLACK='\033[00;30m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
SEA="\\033[38;5;49m"
LIGHTGRAY='\033[00;37m'
LBLACK='\033[01;30m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'
OVERWRITE='\e[1A\e[K'

# emoji codes
CHECK_MARK="${GREEN}\xE2\x9C\x94${NC}"
X_MARK="${RED}\xE2\x9C\x96${NC}"
CLOCK="${GREEN}\xE2\x8C\x9B${NC}"

function _step {
	if [[ $TASK != "" ]]; then
		printf "${OVERWRITE}${LGREEN} [✓]  ${LGREEN}${TASK}\n"
	fi
	TASK=$1
	printf "${LBLACK} [ ]  ${TASK} \n${LRED}"
}

function _step_clear {
	TASK=""
}

function _step_finish{
	printf "${OVERWRITE}${LGREEN} [✓]  ${LGREEN}${TASK}\n"
	_clear_task
}

_step "Installing Ansible"

source /etc/os-release
_step "Loading setup for OS: $ID"
case $ID in
ubuntu)
	ubuntu_setup
	;;
arch)
	arch_setup
	;;
*)
	_step "Unsupported OS"
	_cmd "echo 'Unsupported OS'"
	;;
esac
_task_done

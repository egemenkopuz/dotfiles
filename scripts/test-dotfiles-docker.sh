#!/usr/bin/env bash

set -euo pipefail

# if docker is not installed, exit
if ! command -v docker &>/dev/null; then
	echo "Docker is not installed"
	exit 1
fi

TARGET_OS=${1-ubuntu}
VERBOSE=true
if [[ "$#" -eq 2 && "$2" == "-v" ]]; then
	VERBOSE=false
fi

current_time=$(date "+%Y%m%d-%H%M%S")

IDENTIFIER="$(</dev/urandom tr -dc 'a-z0-9' | fold -w 5 | head -n 1)" || :
SCRIPTS_DIR="$(dirname "$(readlink -f "$0")")"
BASE_DIR="$(readlink -f "${SCRIPTS_DIR}/..")"
LOG_FILENAME="${TARGET_OS}-${IDENTIFIER}-${current_time}.log"
LOG_BASE_DIR="${BASE_DIR}/tests/logs"
LOG_PATH="${LOG_BASE_DIR}/${LOG_FILENAME}"
NAME="dotfiles-test-${TARGET_OS}-${IDENTIFIER}"

function __run_task() {
	if [[ "${VERBOSE}" == "false" ]]; then
		$@
	else
		$@ >/dev/null 2>&1
	fi
}

function __create_tmp_dir() {
	TEMP_DIR=$(mktemp --directory "/tmp/${NAME}".XXXXXXXX)
	export TEMP_DIR
}

function __cleanup() {
	container_id=$(docker inspect --format="{{.Id}}" "${NAME}" || :)
	if [[ -n "${container_id}" ]]; then
		__run_task docker rm --force "${container_id}"
	fi
	if [[ -n "${TEMP_DIR:-}" && -d "${TEMP_DIR:-}" ]]; then
		rm -rf "${TEMP_DIR}"
	fi
}

function __create_tmp_ssh_info() {
	ssh-keygen -b 2048 -t rsa -C "${USER}@email.com" -f "${TEMP_DIR}/id_rsa" -N ""
	chmod 600 "${TEMP_DIR}/id_rsa"
	chmod 644 "${TEMP_DIR}/id_rsa.pub"
}

function __start_container() {
	docker build --tag "dotfiles-test-${TARGET_OS}" \
		--build-arg "USER=${USER}" \
		--file "${BASE_DIR}/tests/Dockerfile.${TARGET_OS}" \
		"${TEMP_DIR}"
	docker run -d -p 127.0.0.1:2222:22 --name "${NAME}" "dotfiles-test-${TARGET_OS}"
	CONTAINER_ADDR=$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "${NAME}")
	export CONTAINER_ADDR
}

function __setup_inv() {
	TEMP_INVENTORY_FILE="${TEMP_DIR}/hosts"

	cat >"${TEMP_INVENTORY_FILE}" <<EOL
[target_group]
127.0.0.1:2222

[target_group:vars]

ansible_ssh_private_key_file=${TEMP_DIR}/id_rsa
EOL
	export TEMP_INVENTORY_FILE
}

function __create_log_dir() {
	mkdir -p "${LOG_BASE_DIR}"
}

function __check_log_results() {
	if [[ -f "${LOG_PATH}" ]]; then
		# parse .results and check if it returned 'null'
		if [[ $(jq '.results' "${LOG_PATH}") != "null" ]]; then
			failed_tasks=$(jq '.results | map(select(.failed == true)) | length' "${LOG_PATH}")
		else
			failed_tasks=1
		fi
		echo "${failed_tasks} failed tasks"
		exit 1
	else
		echo "0 failed tasks"
		exit 0
	fi
}

function __run_playbook() {
	ANSIBLE_CONFIG="${BASE_DIR}/ansible.cfg"
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i "${TEMP_INVENTORY_FILE}" -v "${BASE_DIR}/setup.ansible.yml" --extra-vars "pip_break_system_packages=true log_filename='${LOG_FILENAME}'"
}

trap __cleanup EXIT
trap __cleanup ERR

__run_task __create_tmp_dir
__run_task __create_log_dir
__run_task __create_tmp_ssh_info
__run_task __start_container
__run_task __setup_inv
__run_task __run_playbook

# return number of failed tasks
__check_log_results

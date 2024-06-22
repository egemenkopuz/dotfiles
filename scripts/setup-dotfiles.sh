#!/usr/bin/env bash

DOTFILES_DIR=$(cd $(dirname $0)/.. && pwd)
DOTFILES_SETUP_LOG="${DOTFILES_DIR}/setup.log"
DOTFILES_REPO_URL="https://github.com/egemenkopuz/dotfiles.git"
DOTFILES_REPO_URL_SSH="git@github.com:egemenkopuz/dotfiles.git"

apply_default=false
if [[ $# > 0 ]]; then
	case $1 in
	--default)
		apply_default=true
		;;
	*)
		echo "Invalid argument: $1"
		exit 1
		;;
	esac

fi

declare -A user_roles=()
declare -A default_roles=(
	[core]="installing core essential packages"
	[python]="latest python with specific package(s)"
	[nodejs]="nodejs with specific npm package(s)"
	[nvim]="neovim with specific plugin(s)"
	[fastfetch]="a fast system info tool"
	[eza]="a modern, maintained replacement for ls"
	[bat]="a cat clone with wings"
	[lazygit]="a simple terminal UI for git commands"
	[procs]="a modern replacement for ps"
	[delta]="a viewer for git and diff output"
	[fzf]="a command-line fuzzy finder"
	[ripgrep]="a line-oriented search tool"
	[fd]="a simple, fast and user-friendly alternative to find"
	[zoxide]="a smarter cd command"
	[lf]="a terminal file manager"
	[zsh]="a shell designed for interactive use"
	[git]="configuring .gitconfig"
	[dotfiles]="miscellaneous adjustments, ex: adding zsh exec to .bashrc"
)

declare -A user_role_version=()
declare -A default_role_version=(
	[nodejs]="latest"
	[nvim]="stable"
	[fastfetch]="latest"
	[eza]="latest"
	[bat]="latest"
	[lazygit]="latest"
	[procs]="latest"
	[delta]="latest"
	[fzf]="latest"
	[ripgrep]="latest"
	[fd]="latest"
	[zoxide]="latest"
	[lf]="latest"
)

declare -A user_role_build_source=()
declare -A default_role_build_source=(
	[nvim]="false"
	[fastfetch]="false"
)

declare -A user_python_pkgs=()
declare -A default_python_pkgs=(
	[neovim\-remote]="latest"
	[pynvim]="latest"
	[pre\-commit]="latest"
	[cmake]="latest"
)
declare -A user_nodejs_pkgs=()
declare -A default_nodejs_pkgs=(
	[neovim]="latest"
	[prettier]="latest"
)

# color codes
RED='\033[01;31m'
GREEN='\033[01;32m'
YELLOW='\033[00;33m'
CYAN='\033[00;36m'
WHITE='\033[01;37m'
BLACK='\033[00;30m'
GRAY='\033[01;30m'
NC='\033[0m'
OVERWRITE='\e[1A\e[K'

function __start_task {
	if [[ $TASK != "" ]]; then
		printf "${OVERWRITE}${GREEN}[✓] ${GREEN}${TASK}\n"
	fi
	TASK=$1
	printf "${YELLOW}[ ] ${TASK} \n${RED}"
}

function __reset_task {
	TASK=""
}

function __finish_task {
	if [[ $# > 0 ]] && [[ $1 != "" ]]; then
		printf "${OVERWRITE}${GREEN}[✓] ${GREEN}$1\n"
	else
		printf "${OVERWRITE}${GREEN}[✓] ${GREEN}${TASK}\n"
	fi
	__reset_task
}

function __terminate_task {
	if [[ $# > 0 ]] && [[ $1 != "" ]]; then
		printf "${OVERWRITE}${RED}[X] ${TASK}${RED}\n"
		printf "\t> $1\n"
	else
		printf "${OVERWRITE}${RED}[X] ${TASK}${RED}\n"
	fi
	__reset_task
}

function __cleanup {
	rm -f $DOTFILES_SETUP_LOG
}

function __command {
	if ! [[ -f $DOTFILES_SETUP_LOG ]]; then
		touch $DOTFILES_SETUP_LOG
	fi
	>$DOTFILES_SETUP_LOG
	# check if $1 is a function
	if declare -f "$1" >/dev/null; then
		if "$@" 1>/dev/null 2>$DOTFILES_SETUP_LOG; then
			return 0
		fi
	else
		if eval "$1" 1>/dev/null 2>$DOTFILES_SETUP_LOG; then
			return 0
		fi
	fi
	printf "${OVERWRITE}${RED}[X] ${TASK}${RED}\n"
	while read line; do
		printf "\t> ${line}\n"
	done <$DOTFILES_SETUP_LOG
	printf "\n"
	exit 1
}

function __prompt_yn {
	echo -ne "$1"
	while true; do
		read -n1 -s -p "" yn
		if [[ $yn == "y" ]] || [[ $yn == "Y" ]]; then
			eval "$2=y"
			break
		elif [[ $yn == "n" ]] || [[ $yn == "N" ]]; then
			eval "$2=n"
			break
		fi
	done
	printf "\n"
}

function __prompt {
	echo -ne "$1"
	read -r -p "" ans
	if [[ $ans == "" ]]; then
		eval "$3=$2"
	else
		eval "$3=$ans"
	fi
}

function __override_role_details {
	local prompt
	local ans_yn
	local ans_version
	for role in "${!default_roles[@]}"; do
		__start_task "${role} config setup"
		__prompt_yn "${OVERWRITE}${CYAN}Do you want to include ${RED}${role}${WHITE} (${default_roles[$role]})${CYAN} setup (y/n)?${CR}" ans_yn

		if [[ $ans_yn == "n" ]]; then
			__finish_task "${RED}${role}${GREEN} skipping setup"
			continue
		fi

		user_roles[$role]="true"

		if ! [[ -n ${default_role_version[$role]} ]]; then
			if [[ $role == "python" ]]; then
				for pkg in "${!default_python_pkgs[@]}"; do
					__prompt_yn "${OVERWRITE}${CYAN}Do you want to include ${WHITE}${pkg}${RED} python${CYAN} package (y/n)?${CR}" ans_yn
					if [[ $ans_yn == "y" ]]; then
						__prompt "${OVERWRITE}${CYAN}Enter version for ${WHITE}${pkg}${RED} python${CYAN} (default: ${default_python_pkgs[$pkg]}), press enter to use default:${CR}" "latest" ans_version
						user_python_pkgs[$pkg]="$ans_version"
					fi
				done
				__finish_task "${RED}${role}${GREEN} config setup | python packages: ${WHITE}${!default_python_pkgs[*]}${GREEN}"
			else
				__finish_task "${RED}${role}${GREEN} config setup"
			fi
		else
			__prompt "${OVERWRITE}${CYAN}Enter ${RED}${role} ${CYAN}version (default: ${default_role_version[$role]}), press enter to use default:${CR}" "${default_role_version[$role]}" ans_version
			user_role_version[$role]="$ans_version"

			if [[ -n ${default_role_build_source[$role]} ]]; then
				__prompt_yn "${OVERWRITE}${CYAN}Do you want to build ${RED}${role} ${CYAN}from source (y/n)?${CR}" ans_yn
				if [[ $ans_yn == "y" ]]; then
					user_role_build_source[$role]="true"
				else
					user_role_build_source[$role]="false"
				fi
			else
				user_role_build_source[$role]="false"
			fi

			if [[ $role == "nodejs" ]]; then
				for pkg in "${!default_nodejs_pkgs[@]}"; do
					__prompt_yn "${OVERWRITE}${CYAN}Do you want to include ${WHITE}${pkg}${RED} nodejs${CYAN} package (y/n)?${CR}" ans_yn
					if [[ $ans_yn == "y" ]]; then
						__prompt "${OVERWRITE}${CYAN}Enter version for ${WHITE}${pkg}${RED} nodejs${CYAN} (default: latest), press enter to use default:${CR}" "latest" ans_version
						if [[ $ans_version != "" ]]; then
							user_nodejs_pkgs[$pkg]="$ans_version"
						fi
					fi
				done
				__finish_task "${RED}${role}${GREEN} config setup | version: ${WHITE}${user_role_version[$role]}${GREEN}, build from source: ${WHITE}${user_role_build_source[$role]}${GREEN}, nodejs packages: ${WHITE}${!default_nodejs_pkgs[*]}"
			else
				__finish_task "${RED}${role}${GREEN} config setup | version: ${WHITE}${user_role_version[$role]}${GREEN}, build from source: ${WHITE}${user_role_build_source[$role]}${GREEN}"
			fi

		fi

	done
}

function __detect_os {
	declare -n id=$1
	if [[ -f /etc/os-release ]]; then
		source /etc/os-release
		case $ID in
		"ubuntu")
			id="ubuntu"
			;;
		"arch")
			id="arch"

			;;
		*)
			if [[ -n $ID_LIKE ]]; then
				case $ID_LIKE in
				"debian")
					id="debian"
					;;
				esac
			else
				id="not_supported"

			fi
			;;
		esac
	else
		if [[ $(uname) == "Darwin" ]]; then
			id="macos"
		else
			id="not_supported"
		fi
	fi
}

function __install_debian_deps {
	__start_task "Installing dependencies for ${os}"
	__command "sudo apt-get update"
	if ! dpkg -s python3 >/dev/null 2>&1; then
		__command "sudo apt-get install -y python3"
	fi
	if ! dpkg -s python3-pip >/dev/null 2>&1; then
		__command "sudo apt-get install -y python3-pip"
	fi
	if ! command -v ansible &>/dev/null; then
		__command "python3 -m pip install ansible"
	fi
}

function __install_arch_deps {
	__start_task "Installing dependencies for ${os}"
	__command "sudo pacman -Sy --noconfirm"
	if ! command -v ansible &>/dev/null; then
		__command "sudo pacman -S --noconfirm ansible"
	fi
}

function __install_macos_deps {
	__start_task "Installing dependencies for ${os}"
	if ! command -v brew &>/dev/null; then
		__command '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
	fi
	if ! command -v ansible &>/dev/null; then
		__command "brew install ansible"
	fi
}

function __clone_dotfiles {
	__start_task "Cloning dotfiles from: $DOTFILES_REPO_URL"
	if [[ -d $DOTFILES_DIR ]]; then
		local repo_url=$(git -C $DOTFILES_DIR config --get remote.origin.url)
		if [[ $repo_url != $DOTFILES_REPO_URL ]] && [[ $repo_url != $DOTFILES_REPO_URL_SSH ]]; then
			__prompt_yn "Dotfiles already cloned with different origin $repo_url, do you want to update it (y/n)? " ans_yn
			if [[ $ans_yn == "y" ]]; then
				__prompt_yn "Do you want to keep the existing changes (y/n)? " ans_keep_changes
				__command "git -C $DOTFILES_DIR remote set-url origin $DOTFILES_REPO_URL"
				__command "git -C $DOTFILES_DIR fetch --all"
				if [[ $ans_keep_changes == "y" ]]; then
					__command "git -C $DOTFILES_DIR git reset origin/master"
					__command "git -C $DOTFILES_DIR stash"
					__command "git -C $DOTFILES_DIR stash drop"
					__finish_task "Dotfiles updated without removing already existing changes"
				else
					__command "git -C $DOTFILES_DIR reset --hard"
					__finish_task "Dotfiles updated and existing changes removed"

				fi
			else
				__finish_task "Skipping dotfiles cloning, existing dotfiles will be used"
			fi
		else
			__finish_task "Skipping dotfiles cloning, directory already exists"
		fi
	else
		__command "git clone $DOTFILES_REPO_URL $DOTFILES_DIR"
		__finish_task "Dotfiles cloned"
	fi
}

function __form_ansible_vars {
	__start_task "Forming ansible variable arguments"
	declare -n vars=$1
	vars=""
	for role in "${!user_role_version[@]}"; do
		vars+=" -e '{\"${role}\":{\"version\":\"${user_role_version[$role]}\",\"build_from_source\":\"${user_role_build_source[$role]}\"}}'"
	done
}

function __form_ansible_tags {
	__start_task "Forming ansible tag arguments"
	declare -n tags=$1
	tags=""
	for role in "${!user_roles[@]}"; do
		tags+=" -t ${role}"
	done
}

function __form_python_vars {
	__start_task "Forming python package variable arguments"
	declare -n pkgs=$1
	pkg_list=""
	if [[ ${#user_python_pkgs[@]} == 0 ]]; then
		pkgs=""
		return
	fi
	for pkg in "${!user_python_pkgs[@]}"; do
		if [[ ${user_python_pkgs[$pkg]} == "latest" ]] || [[ ${user_python_pkgs[$pkg]} == "" ]]; then
			pkg_list+="\"${pkg}\","
		else
			pkg_list+="\"${pkg}==${user_python_pkgs[$pkg]}\","
		fi
	done
	pkgs="-e '{\"python_pkgs\":[${pkg_list}]}'"
}

function __form_nodejs_vars {
	__start_task "Forming nodejs package variable arguments"
	declare -n pkgs=$1
	local pkg_list=""
	if [[ ${#user_nodejs_pkgs[@]} == 0 ]]; then
		pkgs=""
		return
	fi
	for pkg in "${!user_nodejs_pkgs[@]}"; do
		pkg_list+="\"${pkg}\","
	done
	pkgs+="--extra-vars '{\"nodejs_pkgs\":[${pkg_list}]}'"
}

function __update_ansible_galaxy {
	__start_task "Updating ansible galaxy roles"
	__command "ansible-galaxy install -r $DOTFILES_DIR/requirements.yml"
}

function __run_ansible_playbook {
	__start_task "Running ansible playbook"
	if [[ $1 == "" ]]; then
		__terminate_task "No roles selected to run playbook"
		exit 1
	fi
	__finish_task
	cd $DOTFILES_DIR
	echo -ne "${CYAN}Running ansible playbook with arguments: ${WHITE}$1 $2 $3 $4${NC}\n"
	eval "ansible-playbook -K $DOTFILES_DIR/setup.ansible.yml ${1} ${2} ${3} ${4}"
}

# -------------- Execution starts here --------------

trap __cleanup EXIT
trap __cleanup ERR

__detect_os os
if [[ $os == "not_supported" ]]; then
	__terminate_task "OS not supported"
	exit 1
fi

if [[ $apply_default == true ]]; then
	__start_task "Applying default values"
	for role in "${!default_role_version[@]}"; do
		if [[ -n ${user_role_version[$role]} ]]; then
			user_role_version[$role]=${default_role_version[$role]}
		else
			user_role_version[$role]="latest"
		fi
	done
	for role in "${!default_role_version[@]}"; do
		if [[ -n ${user_role_build_source[$role]} ]]; then
			user_role_build_source[$role]=${default_role_build_source[$role]}
		else
			user_role_build_source[$role]="false"
		fi
	done
else
	__override_role_details
fi

__start_task "Detected OS: $os"
if [[ $os == "debian" ]] || [[ $os == "ubuntu" ]]; then
	__install_debian_deps
fi
if [[ $os == "arch" ]]; then
	__install_arch_deps
fi
if [[ $os == "macos" ]]; then
	__install_macos_deps
fi

__clone_dotfiles
__form_ansible_vars ansible_version_vars
__form_python_vars ansible_python_vars
__form_nodejs_vars ansible_nodejs_vars
__form_ansible_tags ansible_tags
__update_ansible_galaxy
__run_ansible_playbook "$ansible_tags" "$ansible_version_vars" "$ansible_python_vars" "$ansible_nodejs_vars"

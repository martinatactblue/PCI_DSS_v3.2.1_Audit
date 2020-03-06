#!/usr/bin/env bash

colors() {
  RESET="\033[0m"
  DEFAULT="\033[39m"
  BLACK="\033[30m"
  RED="\033[31m"
  GREEN="\033[32m"
  YELLOW="\033[33m"
  BLUE="\033[34m"
  MAGENTA="\033[35m"
  CYAN="\033[36m"
  GRAY="\033[37m"
}

_info() {
  echo -e "${DEFAULT}INFO: $*${RESET}"
}

_warn() {
  echo -e "${YELLOW}WARNING: $*${RESET}"
}

_error() {
  echo -e "${RED}ERROR: $*${RESET}"
}

_debug() {
  LEVEL=$1
  shift
  if [[ ${DEBUG_LEVEL} -ge ${LEVEL} ]]; then
    echo -e "${CYAN}DEBUG: $*${RESET}"
  fi
}

get_script_dir() {
  SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$( readlink "$SOURCE" )"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  done
  $( cd -P "$( dirname "$SOURCE" )" )
  pwd
}

colors

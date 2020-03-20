    #!/bin/bash

# PCI_Audit - Checks Linux systems for PCI Compliance

set -euo pipefail

PCI_AUDIT_VERSION=0.1.0
PCI_AUDIT_DATE=${PCI_AUDIT_DATE:-$(date +%m.%d.%y-%H.%M)}
export DEBUG_LEVEL=${PCI_AUDIT_DEBUG_LEVEL-0}
export ARCHIVE_DEBUG_LEVEL=${PCI_AUDIT_ARCHIVE_DEBUG_LEVEL-3}
export MAX_DEBUG_LEVEL=5
PCI_AUDIT_SITENAME=${PCI_AUDIT_SITENAME-"notset"}
export PCI_AUDIT_REQUIREMENTS=8

source ./helpers.sh

PCI_AUDIT_ROOT_DIR=${PCI_AUDIT_ROOT_DIR:-$(get_script_dir)/Audit}

get_site_name() {
  if [[ ${PCI_AUDIT_SITENAME} = "notset" ]]; then
    echo "Enter Site Name:"
      read PCI_AUDIT_SITENAME
  fi
}

create_archive() {
  cd ${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}
  if [[ ${DEBUG_LEVEL} -ge ${ARCHIVE_DEBUG_LEVEL} ]]; then
    tar czvf ${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz Req_${PCI_AUDIT_REQUIREMENT}
  else
    tar czf ${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz Req_${PCI_AUDIT_REQUIREMENT}
  fi
  cd $(dirname ${PCI_AUDIT_ROOT_DIR})
}

parse_requirements() {
  if [[ -z ${REQUIREMENT[@]} ]]; then
    _debug 1 "No requirements were passed"
    for requirement in ${PCI_AUDIT_REQUIREMENTS}; do
      export PCI_AUDIT_REQUIREMENT=${requirement}
      if [[ ! -d ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT} ]]; then
        mkdir ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}
      fi

      cd Req_${PCI_AUDIT_REQUIREMENT}
      ./Req_${PCI_AUDIT_REQUIREMENT}.sh
      cd $(dirname $(get_script_dir))

      _debug 1 "Current location: $(get_script_dir)"
    done
  fi

  for argument in "${REQUIREMENT[@]}"; do
    _debug 2 "Requirement Passed: ${argument}"
    export PCI_AUDIT_REQUIREMENT=$(echo ${argument} | cut -d. -f1)
    _debug 2 "PCI_AUDIT_REQUIREMENT: ${PCI_AUDIT_REQUIREMENT}"
    export PCI_AUDIT_SUB_REQUIREMENT=$(echo ${argument} | cut -d. -f2 -s)
    _debug 2 "PCI_AUDIT_SUB_REQUIREMENT: ${PCI_AUDIT_SUB_REQUIREMENT}"
    export PCI_AUDIT_SUB_SUB_REQUIREMENT=$(echo ${argument} | cut -d. -f3 -s)
    _debug 2 "PCI_AUDIT_SUB_SUB_REQUIREMENT: ${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
    if [[ ! -d ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT} ]]; then
      mkdir ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}
    fi

    cd Req_${PCI_AUDIT_REQUIREMENT}
    ./Req_${PCI_AUDIT_REQUIREMENT}.sh
    cd $(dirname $(get_script_dir))

    _debug 1 "Current location: $(get_script_dir)"
  done
}

usage() {
  echo "Usage: $0 [-h]"
  echo "       $0 [-d debug_level] [-s sitename] [[-r requirement][ ...] [-o directory]"
}

main() {
  while getopts ":hd:r:s:o:" option; do
    case "${option}" in
      "d")
        DEBUG_LEVEL="${OPTARG}"
        _debug 1 "Debugging enabled"
        ;;
      "h")
        usage
        exit 0
        ;;
      "o")
        PCI_AUDIT_ROOT_DIR="${OPTARG}"
        ;;
      "r")
        REQUIREMENT+=("${OPTARG}")
        ;;
      "s")
        PCI_AUDIT_SITENAME="${OPTARG}"
        ;;
      *)
        usage
        exit 1
        ;;
    esac
  done

  # no options were provided or there was a mistake
  # if [ "$OPTIND" -eq "1" ] || [ "$OPTIND" -le "$#" ]; then
  if [[ "$OPTIND" -le "$#" ]]; then
    usage
    exit 1
  fi

  clear
  if [ ${DEBUG_LEVEL} -ge ${MAX_DEBUG_LEVEL} ]; then
    _debug 1 "Maximum Debugging enabled"
    set -x # Turn on full debugging
  fi
  echo "                 PCI DSS 3.2.1 Audit v${PCI_AUDIT_VERSION}"
  echo "------------------------------------------------------------"

  get_site_name

  # Create a temp directory
  export PCI_AUDIT_TEMPDIR=${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}
  if [ ! -d "$PCI_AUDIT_ROOT_DIR" ]; then
          mkdir "$PCI_AUDIT_ROOT_DIR"
  fi

  # If there are issues with directory creation
  if [ -d "$PCI_AUDIT_TEMPDIR" ]; then
  	_error "${PCI_AUDIT_TEMPDIR} already exists. Rename the folder to prevent data loss"
    exit 1
  else
      mkdir ${PCI_AUDIT_TEMPDIR}
  fi

  _debug 1 "Current location: $(get_script_dir)"
  _debug 1 "Current script: $0"

  export PCI_AUDIT_SCRIPT_DIR=$(get_script_dir)

  parse_requirements

  create_archive

  _debug 1 "Current location: $(get_script_dir)"

  _info "Audit archives are located in ${PCI_AUDIT_ROOT_DIR}"

  exit 0
}

main "$@"

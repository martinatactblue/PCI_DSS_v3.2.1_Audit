#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# Requirement 2: Do not use vendor-supplied defaults for system passwords and
# other security parameters
#
# Malicious individuals (external and internal to an entity) often use vendor
# default passwords and other vendor default settings to compromise systems.
# These passwords and settings are well known by hacker communities and are
# easily determined via public information.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}
PCI_AUDIT_SUB_REQUIREMENTS="1 2"
PCI_AUDIT_SUB_REQUIREMENT=${PCI_AUDIT_SUB_REQUIREMENT:-${PCI_AUDIT_SUB_REQUIREMENTS}}

_debug 2 "PCI_AUDIT_SUB_REQUIREMENT: ${PCI_AUDIT_SUB_REQUIREMENT}"
_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info  "Capturing Current User"
_info "--------------------------------------------------"
whoami >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Current_User.txt

_info "--------------------------------------------------"
_info  "Capturing Currently Connected Users"
_info "--------------------------------------------------"
w >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Currently_Connected_Users.txt

for sub_requirement in ${PCI_AUDIT_SUB_REQUIREMENT}; do
  export PCI_AUDIT_SUB_REQUIREMENT=${sub_requirement}
  _debug 2 "PCI_AUDIT_SUB_REQUIREMENT: ${PCI_AUDIT_SUB_REQUIREMENT}"
  if [[ ! -d ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT} ]]; then
    mkdir ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}
  fi

  cd ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}
  ./${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.sh

  # Return to the parent directory
  cd $(dirname $(get_script_dir))

  _debug 1 "Current location: $(get_script_dir)"
done

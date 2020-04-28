#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# Requirement 10: Track and monitor all access to network resources and
# cardholder data
#
# Logging mechanisms and the ability to track user activities are critical in
# preventing, detecting, or minimizing the impact of a data compromise. The
# presence of logs in all environments allows thorough tracking, alerting, and
# analysis when something does go wrong. Determining the cause of a compromise
# is very difficult, if not impossible, without system activity logs.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}
PCI_AUDIT_SUB_REQUIREMENTS="1 2" # 3 4 5
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

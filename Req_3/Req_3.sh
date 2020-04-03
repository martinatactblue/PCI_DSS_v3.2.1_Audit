#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# Requirement 3: Protect stored cardholder data
#
# Protection methods such as encryption, truncation, masking, and hashing are
# critical components of cardholder data protection. If an intruder circumvents
# other security controls and gains access to encrypted data, without the proper
# cryptographic keys, the data is unreadable and unusable to that person. Other
# effective methods of protecting stored data should also be considered as
# potential risk mitigation opportunities. For example, methods for minimizing
# risk include not storing cardholder data unless absolutely necessary,
# truncating cardholder data if full PAN is not needed, and not sending
# unprotected PANs using end-user messaging technologies, such as e-mail and
# instant messaging.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}
PCI_AUDIT_SUB_REQUIREMENTS="2"
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

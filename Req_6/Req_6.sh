#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# Requirement 6: Develop and maintain secure systems and applications
# Unscrupulous individuals use security vulnerabilities to gain privileged
# access to systems. Many of these vulnerabilities are fixed by vendor-provided
# security patches, which must be installed by the entities that manage the
# systems. All systems must have all appropriate software patches to protect
# against the exploitation and compromise of cardholder data by malicious
# individuals and malicious software.
#
# Note: Appropriate software patches are those patches that have been evaluated
# and tested sufficiently to determine that the patches do not conflict with
# existing security configurations. For in-house developed applications,
# numerous vulnerabilities can be avoided by using standard system development
# processes and secure coding techniques.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}
PCI_AUDIT_SUB_REQUIREMENTS="2 4"
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

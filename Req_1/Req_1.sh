#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# Requirement 1: Install and maintain a firewall configuration to protect
# cardholder data
# Firewalls are devices that control computer traffic allowed between an
# entity’s networks (internal) and untrusted networks (external), as well as
# traffic into and out of more sensitive areas within an entity’s internal
# trusted networks. The cardholder data environment is an example of a more
# sensitive area within an entity’s trusted network.
#
# A firewall examines all network traffic and blocks those transmissions that do
# not meet the specified security criteria.
#
# All systems must be protected from unauthorized access from untrusted
# networks, whether entering the system via the Internet as e-commerce,
# employee Internet access through desktop browsers, employee e-mail access,
# dedicated connections such as business-to-business connections, via wireless
# networks, or via other sources. Often, seemingly insignificant paths to and
# from untrusted networks can provide unprotected pathways into key systems.
# Firewalls are a key protection mechanism for any computer network.
#
# Other system components may provide firewall functionality, as long as they
# meet the minimum requirements for firewalls as defined in Requirement 1.
# Where other system components are used within the cardholder data environment
# to provide firewall functionality, these devices must be included within the
# scope and assessment of Requirement 1.

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

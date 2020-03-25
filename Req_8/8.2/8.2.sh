#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 8.2 In addition to assigning a unique ID, ensure proper user-authentication
# management for non-consumer users and administrators on all system components
# by employing at least one of the following methods to authenticate all users:
# - Something you know, such as a password or passphrase
# - Something you have, such as a token device or smart card
# - Something you are, such as a biometric.
#
# Testing Procedures
# 8.2 To verify that users are authenticated using unique ID and additional
# authentication (for example, a password/phrase) for access to the cardholder
# data environment, perform the following:
# - Examine documentation describing the authentication method(s) used.
# - For each type of authentication method used and for each type of system
#   component, observe an authentication to verify authentication is functioning
#   consistent with documented authentication method(s).

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_SUB_SUB_REQUIREMENTS="1 3 4 5 6"
PCI_AUDIT_SUB_SUB_REQUIREMENT=${PCI_AUDIT_SUB_SUB_REQUIREMENT:-${PCI_AUDIT_SUB_SUB_REQUIREMENTS}}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

if [[ ! -d ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT} ]]; then
    mkdir ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}
fi

for sub_sub_req in ${PCI_AUDIT_SUB_SUB_REQUIREMENT}; do
    export PCI_AUDIT_SUB_SUB_REQUIREMENT=${sub_sub_req}
    _debug 2 "PCI_AUDIT_SUB_SUB_REQUIREMENT: ${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
    if [[ ! -d ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT} ]]; then
        mkdir ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}
    fi
    cd ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}
    ./${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}.sh
    cd $(dirname $(get_script_dir)) # Return to this directory
done

_debug 1 "Current location: $(get_script_dir)"

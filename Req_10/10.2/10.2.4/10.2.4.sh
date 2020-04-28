#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 10.2.4 Invalid login access attempts
#
# Testing Procedures
# 10.2.4 Verify invalid login access attempts are logged.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Invalid Login Attempts"
_info "--------------------------------------------------"
grep -i "Failed password" /var/log/auth.log 2>> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Invalid_Login_Attempts.txt || true


# Return to the parent directory
cd $(dirname $(get_script_dir))

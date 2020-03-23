#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 8.1.6 Limit repeated access attempts by locking out the user ID after not more
# than six attempts.
#
# Testing Procedures
# 8.1.6.a For a sample of system components, inspect system configuration
# settings to verify that authentication parameters are set to require that user
# accounts be locked out after not more than six invalid logon attempts.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

grep MaxAuthTries /etc/ssh/sshd_config >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Maximum_Logon_Attempt_Lockout.txt || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

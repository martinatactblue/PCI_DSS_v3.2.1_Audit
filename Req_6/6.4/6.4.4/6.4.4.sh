#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 6.4.4 Removal of test data and accounts from system components before the
# system becomes active / goes into production.
#
# Testing Procedures
# 6.4.4.a Observe testing processes and interview personnel to verify test data
# and accounts are removed before a production system becomes active.
#
# 6.4.4.b Examine a sample of data and accounts from production systems recently
# installed or updated to verify test data and accounts are removed before the
# system becomes active.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing User Information"
_info "--------------------------------------------------"
cat /etc/passwd | cut -d: -f1 >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Users.txt
echo "No test data or test accounts are ever configured on this system." >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Test_Data_Accounts.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

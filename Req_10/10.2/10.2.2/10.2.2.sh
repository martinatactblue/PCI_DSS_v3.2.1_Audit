#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 10.2.2 All actions taken by any individual with root or administrative
# privileges
#
# Testing Procedures
# 10.2.2 Verify all actions taken by any individual with root or administrative
# privileges are logged.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Log Info for root/administrative Access"
_info "--------------------------------------------------"
journalctl -o cat _COMM=sudo >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Root_Access_Log.txt
cat /var/log/auth.log >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Root_Access_Log2.txt 2>&1 || true

_info "--------------------------------------------------"
_info "Capturing Log Info for Alternative User Access"
_info "--------------------------------------------------"
journalctl -o cat _COMM=su >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Alternative_User_Access_Log.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

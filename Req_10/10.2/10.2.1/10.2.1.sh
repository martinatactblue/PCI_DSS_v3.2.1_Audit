#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 10.2.1 All individual user accesses to cardholder data
#
# Testing Procedures
# 10.2.1 Verify all individual access to cardholder data is logged.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Log Info for User Creation"
_info "--------------------------------------------------"
journalctl _COMM=useradd >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_User_Creation_Log.txt

_info "--------------------------------------------------"
_info "Capturing User Access Log Info"
_info "--------------------------------------------------"
last -aiF >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_User_Access_Log.txt
journalctl -u ssh >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_User_Access_Log2.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 10.2.6 Initialization, stopping, or pausing of the audit logs
#
# Testing Procedures
# 10.2.6 Verify the following are logged:
#        - Initialization of audit logs
#        - Stopping or pausing of audit logs.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Audit Log Restarts"
_info "--------------------------------------------------"
last reboot >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Audit_Log_Restarts.txt 2>&1 || true
sudo lastb reboot >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Audit_Log_Restarts.txt 2>&1 || true


# Return to the parent directory
cd $(dirname $(get_script_dir))

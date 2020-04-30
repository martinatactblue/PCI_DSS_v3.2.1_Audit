#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 10.2.3 Access to all audit trails
#
# Testing Procedures
# 10.2.3 Verify access to all audit trails is logged.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Audit Trail Access"
_info "--------------------------------------------------"
cat /etc/audit.rules >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Audit_Trail_Access.txt 2>&1 || true
cat /etc/systemd/journald.conf >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Journal_Config.txt 2>&1 || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

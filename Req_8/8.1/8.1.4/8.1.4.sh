#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 8.1.4 Remove/disable inactive user accounts within 90 days.
#
# Testing Procedures
# 8.1.4 Observe user accounts to verify that any inactive accounts over 90 days
# old are either removed or disabled.

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
cat /etc/passwd | cut -d: -f1,5,7|grep -v nologin|grep -v false >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Enabled_Logins.txt
last >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Last_Users_Connected.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

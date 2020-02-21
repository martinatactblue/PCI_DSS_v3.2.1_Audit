#!/bin/bash

# PCI DSS Requirements
# 8.1.1 Assign all users a unique ID before allowing them to access system
# components or cardholder data.
#
# Testing Procedures
# 8.1.1 Interview administrative personnel to confirm that all users are
# assigned a unique ID for access to system components or cardholder data.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing User Information"
_info "--------------------------------------------------"
cat /etc/passwd | cut -d: -f1,5,7|grep -v nologin|grep -v false >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Enabled_Logins.txt
last >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Last_Users_Connected.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

#!/bin/bash

# PCI DSS Requirements
# 8.1.2 Control addition, deletion, and modification of user IDs, credentials,
# and other identifier objects.
#
# Testing Procedures
# 8.1.2 For a sample of privileged user IDs and general user IDs, examine
# associated authorizations and observe system settings to verify each user ID
# and privileged user ID has been implemented with only the privileges specified
# on the documented approval.

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
cat /etc/passwd | cut -d: -f1,5 >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Users.txt
cat /etc/group | cut -d: -f1,2 >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Groups.txt

_info "--------------------------------------------------"
_info "Capturing Administrator Information"
_info "--------------------------------------------------"
grep -v -E "^#" /etc/passwd | awk -F: '$3 == 0 { print $1}' >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Administrators.txt
sudo cat /etc/sudoers >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Administrators2.txt || true
if [[ -d /etc/sudoers.d ]]; then
    for fname in $(sudo ls /etc/sudoers.d/|grep -v README); do
        sudo cat /etc/sudoers.d/${fname} >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Administrators2.txt || true
    done
fi
awk -F: '($3 == "0") {print}' /etc/passwd >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Administrators3.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

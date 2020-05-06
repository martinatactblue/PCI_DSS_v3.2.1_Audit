#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 8.1.3 Immediately revoke access for any terminated users.
#
# Testing Procedures
# 8.1.3.a Select a sample of users terminated in the past six months, and review
# current user access lists—for both local and remote access—to verify that
# their IDs have been deactivated or removed from the access lists.
#
# 8.1.3.b Verify all physical authentication methods—such as, smart cards,
# tokens, etc.—have been returned or deactivated.

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

_info "--------------------------------------------------"
_info "Capturing Remote Access Information"
_info "--------------------------------------------------"
echo "No .shost files allowed:" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Shosts_Files.txt
sudo find / -name '*.shosts' >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Shosts_Files.txt 2>&1 || true
echo "No shosts.equiv files allowed:" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Shosts_Files.txt
sudo find / -name shosts.equiv >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Shosts_Files.txt 2>&1 || true
echo "Authorized keys files:" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Authorized_Keys_Files.txt
sudo find / -name authorized_keys >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Authorized_Keys_Files.txt 2>&1 || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

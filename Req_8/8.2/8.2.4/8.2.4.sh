#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
#
#
# Testing Procedures
#

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Gathering Password Configuration Settings"
_info "--------------------------------------------------"

echo -e "Password Rules\n--------------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
grep PASS /etc/login.defs >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt || true
for username in $(cat /etc/passwd|cut -d: -f1); do
  echo -e "-----\n$username:" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Expirations.txt
  sudo chage -l $username >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Expirations.txt || true
done
# Return to the parent directory
cd $(dirname $(get_script_dir))

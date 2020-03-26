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
_todo "Not yet implemented"
_info "--------------------------------------------------"

echo -e "Password Rules\n--------------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
echo "Operating System Defaults:" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
echo "This cannot be confirmed via specific configuration settings" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
echo "--------------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
echo "This is done via use of the 'chage --lastday' command at user creation time" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
echo "e.g.: chage --lastday 0 username" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

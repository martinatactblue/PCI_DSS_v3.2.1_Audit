#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 8.2.5 Do not allow an individual to submit a new password/passphrase that is
# the same as any of the last four passwords/passphrases he or she has used.
#
# Testing Procedures
# 8.2.5.a For a sample of system components, obtain and inspect system
# configuration settings to verify that password parameters are set to require
# that new passwords/passphrases cannot be the same as the four previously used
# passwords/passphrases.
# 8.2.5.b Additional testing procedure for service provider assessments only:
# Review internal processes and customer/user documentation to verify that new
# non-consumer customer user passwords/passphrase cannot be the same as the
# previous four passwords.

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
echo "Operating System Defaults:" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
echo "No check for previously used passwords" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
echo "--------------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
grep remember /etc/pam.d/login >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

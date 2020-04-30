#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 8.2.3 Passwords/passphrases must meet the following:
# - Require a minimum length of at least seven characters.
# - Contain both numeric and alphabetic characters.
#
# Alternatively, the passwords/ passphrases must have complexity and strength at
# least equivalent to the parameters specified above.
#
# Testing Procedures
# 8.2.3a For a sample of system components, inspect system configuration
# settings to verify that user password/passphrase parameters are set to require
# at least the following strength/complexity:
# - Require a minimum length of at least seven characters.
# - Contain both numeric and alphabetic characters.
# 8.2.3.b Additional testing procedure for service provider assessments only:
# Review internal processes and customer/user documentation to verify that
# non-consumer customer passwords/passphrases are required to meet at least the
# following strength/complexity:
# - Require a minimum length of at least seven characters.
# - Contain both numeric and alphabetic characters.

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

echo -e "Installed Password Libaries\n---------------------------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Libraries.txt
dpkg --list|grep libpam|grep pass >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Libraries.txt || true
echo -e "Password Rules\n--------------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
echo "Operating System Defaults:" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
echo "Minimum password length of 6 characters"  >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
echo "No check for both numeric and alphabetic characters" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt
echo "--------------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt

grep minlen /etc/pam.d/login >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt || true
grep minclass /etc/pam.d/common-password >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

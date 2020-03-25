#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 8.2.1 Using strong cryptography, render all authentication credentials (such
# as passwords/phrases) unreadable during transmission and storage on all system
# components.
#
# Testing Procedures
# 8.2.1.a Examine vendor documentation and system configuration settings to
# verify that passwords are protected with strong cryptography during
# transmission and storage.
# 8.2.1.b For a sample of system components, examine password files to verify
# that passwords are unreadable during storage.
# 8.2.1.c For a sample of system components, examine data transmissions to
# verify that passwords are unreadable during transmission.
# 8.2.1.d Additional testing procedure for service provider assessments only:
# Observe password files to verify that non- consumer customer passwords are
# unreadable during storage.
# 8.2.1.e Additional testing procedure for service provider assessments only:
# Observe data transmissions to verify that non-consumer customer passwords are
# unreadable during transmission.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Password Information"
_info "--------------------------------------------------"
cat /etc/passwd | cut -d: -f1,2 >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Passwords.txt
sudo cat /etc/shadow | cut -d: -f1,2 >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Passwords2.txt || true
grep -v \# /etc/pam.d/login >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules.txt || true
grep -v \# /etc/pam.d/common-password >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Password_Rules2.txt || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 10.2.5 Use of and changes to identification and authentication
#        mechanisms—including but not limited to creation of new accounts and
#        elevation of privileges—and all changes, additions, or deletions to
#        accounts with root or administrative privileges
#
# Testing Procedures
# 10.2.5.a Verify use of identification and authentication mechanisms is logged.
# 10.2.5.b Verify all elevation of privileges is logged.
# 10.2.5.c Verify all changes, additions, or deletions to any account with root
#        or administrative privileges are logged.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Elevation of Privileges"
_info "--------------------------------------------------"
journalctl -o cat _COMM=sudo >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Privilege_Elevation.txt


# Return to the parent directory
cd $(dirname $(get_script_dir))

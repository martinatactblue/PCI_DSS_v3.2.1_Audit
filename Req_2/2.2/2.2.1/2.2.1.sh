#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 2.2.1 Implement only one primary function per server to prevent functions that
# require different security levels from co-existing on the same server. (For
# example, web servers, database servers, and DNS should be implemented on
# separate servers.)
#
# Note: Where virtualization technologies are in use, implement only one primary
# function per virtual system component.
#
# Testing Procedures
# 2.2.1.a Select a sample of system components and inspect the system
# configurations to verify that only one primary function is implemented per
# server.
# 2.2.1.b If virtualization technologies are used, inspect the system
# configurations to verify that only one primary function is implemented per
# virtual system component or device.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Running Processes for Primary Function"
_info "--------------------------------------------------"
ps -aux >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Primary_Function.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

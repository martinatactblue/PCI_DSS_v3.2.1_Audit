#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 8.5 Do not use group, shared, or generic IDs, passwords, or other
# authentication methods as follows:
# - Generic user IDs are disabled or removed.
# - Shared user IDs do not exist for system administration and other critical functions.
# - Shared and generic user IDs are not used to administer any system components.
#
# Testing Procedures
# 8.5.a For a sample of system components, examine user ID lists to verify the
# following:
# - Generic user IDs are disabled or removed.
# - Shared user IDs for system administration activities and other
#   critical functions do not exist.
# - Shared and generic user IDs are not used to administer any system components.

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
cat /etc/passwd | cut -d: -f1,7 >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Users.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

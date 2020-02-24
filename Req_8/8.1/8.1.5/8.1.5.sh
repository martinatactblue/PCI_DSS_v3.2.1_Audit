#!/bin/bash

# PCI DSS Requirements
# 8.1.5 Manage IDs used by third parties to access, support, or maintain system
# components via remote access as follows:
# - Enabled only during the time period needed and disabled when not in use.
# - Monitored when in use.
#
# Testing Procedures
# 8.1.5.a Interview personnel and observe processes for managing accounts used
# by third parties to access, support, or maintain system components to verify
# that accounts used for remote access are:
# - Disabled when not in use
# - Enabled only when needed by the third party, and disabled when not in use.
#
# 8.1.5.b Interview personnel and observe processes to verify that third-party
# remote access accounts are monitored while being used.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

echo "There is no third-party account access to this system." >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Third_Party_Account_Access.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

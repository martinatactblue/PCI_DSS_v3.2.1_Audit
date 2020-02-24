#!/bin/bash

# PCI DSS Requirements
# 8.1.7 Set the lockout duration to a minimum of 30 minutes or until an
# administrator enables the user ID.
#
# Testing Procedures
# 8.1.7 For a sample of system components, inspect system configuration settings
# to verify that password parameters are set to require that once a user account
# is locked out, it remains locked for a minimum of 30 minutes or until a system
# administrator resets the account.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

# This is opiniated to Ubuntu
grep tally /etc/pam.d/common-auth >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Lockout_Duration.txt || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

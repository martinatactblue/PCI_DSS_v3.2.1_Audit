#!/bin/bash

# PCI DSS Requirements
# 8.1 Define and implement policies and procedures to ensure proper user
# identification management for non- consumer users and administrators on all
# system components.
#
# Testing Procedures
# 8.1.a Review procedures and confirm they define processes for each of the
# items below at 8.1.1 through 8.1.8.
# 8.1.b Verify that procedures are implemented for user identification
# management.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for ${PCI_AUDIT_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

if [[ ! -d ${PCI_AUDIT_TEMPDIR}/${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_SUB_REQUIREMENT} ]]; then
    mkdir ${PCI_AUDIT_TEMPDIR}/${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_SUB_REQUIREMENT}
fi

for sub_sub_req in 1 2 3 4 5; do
    export PCI_AUDIT_SUB_SUB_REQUIREMENT=8.1.${sub_sub_req}
    if [[ ! -d ${PCI_AUDIT_TEMPDIR}/${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_SUB_SUB_REQUIREMENT} ]]; then
        mkdir ${PCI_AUDIT_TEMPDIR}/${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_SUB_SUB_REQUIREMENT}
    fi
    cd ${PCI_AUDIT_SUB_SUB_REQUIREMENT}
    ./${PCI_AUDIT_SUB_SUB_REQUIREMENT}.sh
    cd $(dirname $(get_script_dir)) # Return to this directory
done

_debug 1 "Current location: $(get_script_dir)"

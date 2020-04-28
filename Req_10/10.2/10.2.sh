#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 10.2 Implement automated audit trails for all system components to reconstruct
# the following events:
#
# 10.2.1 All individual user accesses to cardholder data
# 10.2.2 All actions taken by any individual with root or administrative
#        privileges
# 10.2.3 Access to all audit trails
# 10.2.4 Invalid login access attempts
# 10.2.5 Use of and changes to identification and authentication
#        mechanisms—including but not limited to creation of new accounts and
#        elevatioN of privileges—and all changes, additions, or deletions to
#        accounts with root or administrative privileges
# 10.2.6 Initialization, stopping, or pausing of the audit logs
# 10.2.7 Creation and deletion of system- level objects
#
# Testing Procedures
# 10.2 Through interviews of responsible personnel, observation of audit logs,
# and examination of audit log settings, perform the following:
# 10.2.1 Verify all individual access to cardholder data is logged.
# 10.2.2 Verify all actions taken by any individual with root or administrative
#        privileges are logged.
# 10.2.3 Verify access to all audit trails is logged.
# 10.2.4 Verify invalid login access attempts are logged.
# 10.2.5.a Verify use of identification and authentication mechanisms is logged.
# 10.2.5.b Verify all elevation of privileges is logged.
# 10.2.5.c Verify all changes, additions, or deletions to any account with root
#        or administrative privileges are logged.
# 10.2.6 Verify the following are logged:
#        - Initialization of audit logs
#        - Stopping or pausing of audit logs.
# 10.2.7 Verify creation and deletion of system level objects are logged.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}
PCI_AUDIT_SUB_SUB_REQUIREMENTS="1 2 3 4" # 5 6 7"
PCI_AUDIT_SUB_SUB_REQUIREMENT=${PCI_AUDIT_SUB_SUB_REQUIREMENT:-${PCI_AUDIT_SUB_SUB_REQUIREMENTS}}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

if [[ ! -d ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT} ]]; then
    mkdir ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}
fi

for sub_sub_req in ${PCI_AUDIT_SUB_SUB_REQUIREMENT}; do
    export PCI_AUDIT_SUB_SUB_REQUIREMENT=${sub_sub_req}
    _debug 2 "PCI_AUDIT_SUB_SUB_REQUIREMENT: ${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
    if [[ ! -d ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT} ]]; then
        mkdir ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}
    fi
    cd ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}
    ./${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}.sh
    cd $(dirname $(get_script_dir)) # Return to this directory
done

_debug 1 "Current location: $(get_script_dir)"

#!/bin/bash

# PCI DSS Requirements
# 8.1.8 If a session has been idle for more than 15 minutes, require the user to
# re-authenticate to re-activate the terminal or session.
#
# Testing Procedures
# 8.1.8 For a sample of system components, inspect system configuration settings
# to verify that system/session idle time out features have been set to 15
# minutes or less.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

grep ClientAliveInterval /etc/ssh/sshd_config >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Maximum_Session_Idle_Time.txt
grep ClientAliveCountMax /etc/ssh/sshd_config >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Maximum_Session_Idle_Time.txt
grep LoginGraceTime /etc/ssh/sshd_config >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Maximum_Login_Grace_Time.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

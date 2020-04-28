#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 3.2.2 Do not store the card verification code or value (three-digit or
# four-digit number printed on the front or back of a payment card used to
# verify card-not- present transactions) after authorization.
#
# Testing Procedures
# 3.2.2 For a sample of system components, examine data sources, including but
# not limited to the following, and verify that the three-digit or four-digit
# card verification code or value printed on the front of the card or the
# signature panel (CVV2, CVC2, CID, CAV2 data) is not stored after authorization:
# - Incoming transaction data
# - All logs (for example, transaction, history, debugging, error)
# - History files
# - Trace files
# - Several database schemas
# - Database contents.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Gathering history information"
_info "--------------------------------------------------"
for userdata in $(cat /etc/passwd|cut -d: -f1,7|grep -v nologin|grep -v false|grep -v sync); do
    username=$(echo $userdata|cut -d: -f1)
    # HISTFILE=$(basename $HISTFILE) sudo -i -u $username \
    # sudo -i -u $username HISTFILE=$(basename $HISTFILE) \
    sudo -i -u $username \
        cat \$HOME/.bash_history 2>> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_${username}_history.txt || true
done

# Return to the parent directory
cd $(dirname $(get_script_dir))

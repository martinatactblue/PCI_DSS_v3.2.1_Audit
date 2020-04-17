#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 1.1.7 Requirement to review firewall and router rule sets at least every six
# months.
#
# Testing Procedures
# 1.1.7.a Verify that firewall and router configuration standards require review
# of firewall and router rule sets at least every six months.
#
# 1.1.7.b Examine documentation relating to rule set reviews and interview
# responsible personnel to verify that the rule sets are reviewed at least every
# six months.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Firewall Rulesets"
_info "--------------------------------------------------"
sudo ufw status >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_UFW_Rulesets.txt || true

_info "--------------------------------------------------"
_info "Capturing IPTables Rulesets"
_info "--------------------------------------------------"
sudo iptables -L >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_IPTables_Rulesets.txt || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

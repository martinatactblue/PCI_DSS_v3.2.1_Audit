#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 10.4.1 Critical systems have the correct and consistent time.
#
# Testing Procedures
# 10.4.1.a Examine the process for acquiring, distributing and storing the
# correct time within the organization to verify that:
# - Only the designated central time server(s) receives time signals from
#   external sources, and time signals from external sources are based on
#   International Atomic Time or UTC.
# - Where there is more than one designated time server, the time servers peer
#   with one another to keep accurate time,
# - Systems receive time information only from designated central time server(s).
# 10.4.1.b Observe the time-related system-parameter settings for a sample of
# system components to verify:
# - Only the designated central time server(s) receives time signals from
#   external sources, and time signals from external sources are based on
#   International Atomic Time or UTC.
# - Where there is more than one designated time server, the designated central
#   time server(s) peer with one another to keep accurate time.
# - Systems receive time only from designated central time server(s).

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Time Information"
_info "--------------------------------------------------"
journalctl |grep -i time >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Time_Logs.txt 2>&1 || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

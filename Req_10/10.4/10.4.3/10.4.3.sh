#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 10.4.3 Time settings are received from industry-accepted time sources.
#
# Testing Procedures
# 10.4.3 Examine systems configurations to verify that the time server(s) accept
# time updates from specific, industry-accepted external sources (to prevent a
# malicious individual from changing the clock). Optionally, those updates can
# be encrypted with a symmetric key, and access control lists can be created
# that specify the IP addresses of client machines that will be provided with
# the time updates (to prevent unauthorized use of internal time servers).

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Time Source Information"
_info "--------------------------------------------------"
cat /etc/systemd/timesyncd.conf >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Time_Source.txt 2>&1 || true
cat /etc/ntp.conf >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Time_Source2.txt 2>&1 || true
journalctl |grep -i time >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Time_Source3.txt 2>&1 || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

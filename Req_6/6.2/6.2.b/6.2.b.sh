#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 6.2 Ensure that all system components and software are protected from known
# vulnerabilities by installing applicable vendor-supplied security patches.
# Install critical security patches within one month of release.
#
# Note: Critical security patches should be identified according to the risk
# ranking process defined in Requirement 6.1.
#
# Testing Procedures
# 6.2.b For a sample of system components and related software, compare the list
# of security patches installed on each system to the most recent vendor
# security-patch list, to verify the following:
# - That applicable critical vendor-supplied security patches are installed
#   within one month of release.
# - All applicable vendor-supplied security patches are installed within an
#   appropriate time frame (for example, within three months).

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
cat /etc/issue >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Distribution.txt
cat /etc/lsb-release >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Distribution2.txt
cat /etc/os-release >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Distribution3.txt
cat /proc/version >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Kernel.txt
uname -mrs >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Kernel2.txt
ls /boot | grep vmlinuz >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Kernel3.txt || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

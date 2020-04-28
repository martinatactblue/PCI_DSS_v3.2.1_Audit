#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 2.2.3 Implement additional security features for any required services,
# protocols, or daemons that are considered to be insecure.
#
# Testing Procedures
# 2.2.3 Inspect configuration settings to verify that security features are documented and implemented for all insecure services, daemons, or protocols.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Insecure Services Configurations"
_info "--------------------------------------------------"
echo -e "xinetd\n------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
cat /etc/xinetd.conf >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt 2>&1 || true
echo -e "YP/NIS\n------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
cat /etc/yp.conf >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt 2>&1 || true
yptest >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt 2>&1 || true
echo -e "TFTPd\n------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
cat /etc/inetd.conf >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt 2>&1 || true
cat /etc/default/tftpd-hpa >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt 2>&1 || true
echo -e "Telnet\n------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
cat /etc/hosts.allow >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt 2>&1 || true
cat /etc/hosts.deny >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt 2>&1 || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

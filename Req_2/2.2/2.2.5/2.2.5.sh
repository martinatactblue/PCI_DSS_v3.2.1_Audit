#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 2.2.5 Remove all unnecessary functionality, such as scripts, drivers,
# features, subsystems, file systems, and unnecessary web servers.
#
# Testing Procedures
# 2.2.5.a Select a sample of system components and inspect the configurations to
# verify that all unnecessary functionality (for example, scripts, drivers,
# features, subsystems, file systems, etc.) is removed.
#
# 2.2.5.b. Examine the documentation and security parameters to verify enabled
# functions are documented and support secure configuration.
#
# 2.2.5.c. Examine the documentation and security parameters to verify that only
# documented functionality is present on the sampled system components.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current locat ion: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Kernel Module Information"
_info "--------------------------------------------------"
cat /proc/modules >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Kernel_Modules.txt

_info "--------------------------------------------------"
_info "Capturing Insecure Services Information"
_info "--------------------------------------------------"
dpkg -l xinetd >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
dpkg -l yp-tools >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
dpkg -l atftpd >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
dpkg -l tftpd >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
dpkg -l tftpd-hpa >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
dpkg -l telnetd >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
dpkg -l rsh-server >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
dpkg -l rsh-redone-server >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
dpkg -l nis >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
dpkg -l telnetd >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt
dpkg -l xinetd >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Insecure_Services.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

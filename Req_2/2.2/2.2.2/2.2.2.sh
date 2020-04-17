#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 2.2.2 Enable only necessary services, protocols, daemons, etc., as required
# for the function of the system.
#
# Testing Procedures
# 2.2.2.a Select a sample of system components and inspect enabled system
# services, daemons, and protocols to verify that only necessary services or
# protocols are enabled.
#
# 2.2.2.b Identify any enabled insecure services, daemons, or protocols and
# interview personnel to verify they are justified per documented configuration
# standards.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Services Information"
_info "--------------------------------------------------"
cat /etc/services >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Service_Port_Assignments.txt
service --status-all >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Services_Status.txt
sudo systemctl list-sockets --show-types --all >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Service_Sockets.txt || true
sudo netstat -antpx >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Active_Sockets.txt || true
sudo netstat -antup >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Actve_Connections.txt || true
sudo netstat -tulpn >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Actve_Server_Connections.txt || true
lsof -i >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Open_Files.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

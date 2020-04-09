#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 6.4.1 Separate development/test environments from production environments,
# and enforce the separation with access controls.
#
# Testing Procedures
# 6.4.1.a Examine network documentation and network device configurations to
# verify that the development/test environments are separate from the production
# environment(s).
#
# 6.4.1.b Examine access controls settings to verify that access controls are in
# place to enforce separation between the development/test environments and the
# production environment(s).

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
cat /etc/hosts >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Hosts.txt
/sbin/ifconfig -a >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Network_Configuration.txt
cat /etc/network/interfaces >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Network_Configuration2.txt
cat /etc/resolv.conf >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Network_Configuration3.txt
cat /etc/networks >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Network_Configuration4.txt
hostname >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Hostname.txt
domainname >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Domain_Name.txt
dnsdomainname >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_DNS_Domain_Name.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

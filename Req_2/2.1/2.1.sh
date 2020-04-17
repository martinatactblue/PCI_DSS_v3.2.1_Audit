#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 2.1 Always change vendor-supplied defaults and remove or disable unnecessary
# default accounts before installing a system on the network.
# This applies to ALL default passwords, including but not limited to those used
# by operating systems, software that provides security services, application
# and system accounts, point-of-sale (POS) terminals, payment applications,
# Simple Network Management Protocol (SNMP) community strings, etc.).
#
# Testing Procedures
# 2.1.a Choose a sample of system components, and attempt to log on (with system
# administrator help) to the devices and applications using default
# vendor-supplied accounts and passwords, to verify that ALL default passwords
# (including those on operating systems, software that provides security
# services, application and system accounts, POS terminals, and Simple Network
# Management Protocol (SNMP) community strings) have been changed. (Use vendor
# manuals and sources on the Internet to find vendor-supplied
# accounts/passwords.)
#
# 2.1.b For the sample of system components, verify that all unnecessary default
# accounts (including accounts used by operating systems, security software,
# applications, systems, POS terminals, SNMP, etc.) are removed or disabled.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_SUB_SUB_REQUIREMENTS="a b"
PCI_AUDIT_SUB_SUB_REQUIREMENT=${PCI_AUDIT_SUB_SUB_REQUIREMENT:-${PCI_AUDIT_SUB_SUB_REQUIREMENTS}}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

if [[ ! -d ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT} ]]; then
    mkdir ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}
fi

for sub_sub_req in ${PCI_AUDIT_SUB_SUB_REQUIREMENT}; do
    export PCI_AUDIT_SUB_SUB_REQUIREMENT=${sub_sub_req}
    _debug 2 "PCI_AUDIT_SUB_SUB_REQUIREMENT: ${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
    if [[ ! -d ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT} ]]; then
        mkdir ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}
    fi
    cd ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}
    ./${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}.sh
    cd $(dirname $(get_script_dir)) # Return to this directory
done

_debug 1 "Current location: $(get_script_dir)"

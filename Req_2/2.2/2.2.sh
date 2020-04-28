#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 2.2 Develop configuration standards for all system components. Assure that
# these standards address all known security vulnerabilities and are consistent
# with industry-accepted system hardening standards.
# Sources of industry-accepted system hardening standards may include, but are
# not limited to:
# - Center for Internet Security (CIS)
# - International Organization for Standardization (ISO)
# - SysAdmin Audit Network Security (SANS) Institute
# - National Institute of Standards Technology (NIST).
#
# Testing Procedures
# 2.2.a Examine the organization’s system configuration standards for all types
# of system components and verify the system configuration standards are
# consistent with industry- accepted hardening standards.
#
# 2.2.b Examine policies and interview personnel to verify that system
# configuration standards are updated as new vulnerability issues are
# identified, as defined in Requirement 6.1.
#
# 2.2.c Examine policies and interview personnel to verify that system
# configuration standards are applied when new systems are configured and
# verified as being in place before a system is installed on the network.
#
# 2.2.d Verify that system configuration standards include the following
# procedures for all types of system components:
# - Changing of all vendor-supplied defaults and elimination of unnecessary
#   default accounts
# - Implementing only one primary function per server to prevent functions that
#   require different security levels from co-existing on the same server
# - Enabling only necessary services, protocols, daemons, etc., as required for
#   the function of the system
# - Implementing additional security features for any required services,
#   protocols or daemons that are considered to be insecure
# - Configuring system security parameters to prevent misuse
# - Removing all unnecessary functionality, such as scripts, drivers, features,
# subsystems, file systems, and unnecessary web servers.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_SUB_SUB_REQUIREMENTS="1 2 3 4 5"
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

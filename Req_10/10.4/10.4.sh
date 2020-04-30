#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 10.4 Using time-synchronization technology, synchronize all critical system
# clocks and times and ensure that the following is implemented for acquiring,
# distributing, and storing time.
#
# 10.4.1 Critical systems have the correct and consistent time.
# 10.4.2 Time data is protected.
# 10.4.3 Time settings are received from industry-accepted time sources.
#
# Testing Procedures
# 10.4 Examine configuration standards and processes to verify that
# time-synchronization technology is implemented and kept current per PCI DSS
# Requirements 6.1 and 6.2.
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
# 10.4.2.a Examine system configurations and time- synchronization settings to
# verify that access to time data is restricted to only personnel with a
# business need to access time data.
# 10.4.2.b Examine system configurations, time synchronization settings and
# logs, and processes to verify that any changes to time settings on critical
# systems are logged, monitored, and reviewed.
# 10.4.3 Examine systems configurations to verify that the time server(s) accept
# time updates from specific, industry-accepted external sources (to prevent a
# malicious individual from changing the clock). Optionally, those updates can
# be encrypted with a symmetric key, and access control lists can be created
# that specify the IP addresses of client machines that will be provided with
# the time updates (to prevent unauthorized use of internal time servers).

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}
PCI_AUDIT_SUB_SUB_REQUIREMENTS="1 2 3 4" # 5 6 7"
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

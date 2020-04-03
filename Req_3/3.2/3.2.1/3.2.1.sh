#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 3.2.1 Do not store the full contents of any track (from the magnetic stripe
# located on the back of a card, equivalent data contained on a chip, or
# elsewhere) after authorization. This data is alternatively called full track,
# track, track 1, track 2, and magnetic-stripe data.
#
# Note: In the normal course of business, the following data elements from the
# magnetic stripe may need to be retained:
# - The cardholder’s name
# - Primary account number (PAN)
# - Expiration date
# - Service code
# To minimize risk, store only these data elements as needed for business.
#
# Testing Procedures
# 3.2.1 For a sample of system components, examine data sources including but
# not limited to the following, and verify that the full contents of any track
# from the magnetic stripe on the back of card or equivalent data on a chip are
# not stored after authorization:
# - Incoming transaction data
# - All logs (for example, transaction, history, debugging, error)
# - History files
# - Trace files
# - Several database schemas
# - Database contents.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Gathering log information"
_info "--------------------------------------------------"
cat /var/log/syslog >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_syslog.txt

# Return to the parent directory
cd $(dirname $(get_script_dir))

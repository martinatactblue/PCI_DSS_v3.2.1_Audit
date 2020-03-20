#!/bin/bash

# PCI DSS Requirements
# Requirement 8: Identify and authenticate access to system components
#
# Assigning a unique identification (ID) to each person with access ensures
# that each individual is uniquely accountable for their actions. When such
# accountability is in place, actions taken on critical data and systems are
# performed by, and can be traced to, known and authorized users and processes.
#
# The effectiveness of a password is largely determined by the design and
# implementation of the authentication system—particularly, how frequently
# password attempts can be made by an attacker, and the security methods to
# protect user passwords at the point of entry, during transmission, and while
# in storage.
#
# Note: These requirements are applicable for all accounts, including
# point-of-sale accounts, with administrative capabilities and all accounts
# used to view or access cardholder data or to access systems with cardholder
# data. This includes accounts used by vendors and other third parties (for
# example, for support or maintenance). These requirements do not apply to
# accounts used by consumers (e.g., cardholders).
#
# However, Requirements 8.1.1, 8.2, 8.5, 8.2.3 through 8.2.5, and 8.1.6 through
# 8.1.8 are not intended to apply to user accounts within a point-of-sale
# payment application that only have access to one card number at a time in
# order to facilitate a single transaction (such as cashier accounts).

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}
PCI_AUDIT_SUB_REQUIREMENTS=1
PCI_AUDIT_SUB_REQUIREMENT=${PCI_AUDIT_SUB_REQUIREMENT:-${PCI_AUDIT_SUB_REQUIREMENTS}}

_debug 2 "PCI_AUDIT_SUB_REQUIREMENT: ${PCI_AUDIT_SUB_REQUIREMENT}"
_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info  "Capturing Current User"
_info "--------------------------------------------------"
whoami >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Current_User.txt

_info "--------------------------------------------------"
_info  "Capturing Currently Connected Users"
_info "--------------------------------------------------"
w >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Currently_Connected_Users.txt

# if [[ -z ${PCI_AUDIT_SUB_REQUIREMENT} ]]; then
#   PCI_AUDIT_SUB_REQUIREMENT=${PCI_AUDIT_SUB_REQUIREMENTS}
# fi

for sub_requirement in ${PCI_AUDIT_SUB_REQUIREMENT}; do
  export PCI_AUDIT_SUB_REQUIREMENT=${sub_requirement}
  _debug 2 "PCI_AUDIT_SUB_REQUIREMENT: ${PCI_AUDIT_SUB_REQUIREMENT}"
  if [[ ! -d ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT} ]]; then
    mkdir ${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}
  fi

  cd ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}
  ./${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.sh

  # Return to the parent directory
  cd $(dirname $(get_script_dir))

  _debug 1 "Current location: $(get_script_dir)"
done

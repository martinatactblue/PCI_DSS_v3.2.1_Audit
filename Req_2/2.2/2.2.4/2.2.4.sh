#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 2.2.4 Configure system security parameters to prevent misuse.
#
# Testing Procedures
# 2.2.4.a Interview system administrators and/or security managers to verify
# that they have knowledge of common security parameter settings for system
# components.
#
# 2.2.4.b Examine the system configuration standards to verify that common
# security parameter settings are included.
#
# 2.2.4.c Select a sample of system components and inspect the common security
# parameters to verify that they are set appropriately and in accordance with
# the configuration standards.

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
_info "Capturing System Security Parameters"
_info "--------------------------------------------------"
echo -e "Accounts with Empty Passwords\n-----------------------------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Empty_Passwords.txt
sudo awk -F: '($2 == "") {print}' /etc/shadow >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Empty_Passwords.txt || true
echo -e "Accounts with UID 0\n----------------------------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_UID_0_Accounts.txt
awk -F: '($3 == "0") {print}' /etc/passwd >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_UID_0_Accounts.txt
echo -e "Root Login Disabled\n-------------------" >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Root_Login_Disabled.txt
cat /etc/ssh/sshd_config qq|grep PermitRootLogin >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Root_Login_Disabled.txt
cat /etc/sysctl.conf >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_Kernel_Parameters.txt
sudo find / -perm -4000 >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_SUID_Binaries.txt || true
sudo find / -perm -2000  >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_SGID_Binaries.txt || true
sudo find / \( -nouser -o -nogroup \) -print >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_No_Owner_Files.txt || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

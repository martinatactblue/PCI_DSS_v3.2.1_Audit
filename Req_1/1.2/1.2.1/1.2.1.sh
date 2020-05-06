#!/bin/bash
#shellcheck shell=bash

# PCI DSS Requirements
# 1.2.1 Restrict inbound and outbound traffic to that which is necessary for the
# cardholder data environment, and specifically deny all other traffic.
#
# Testing Procedures
# 1.2.1.a Examine firewall and router configuration standards to verify that
# they identify inbound and outbound traffic necessary for the cardholder data
# environment.
# 1.2.1.b Examine firewall and router configurations to verify that inbound and
# outbound traffic is limited to that which is necessary for the cardholder data
# environment.
# 1.2.1.c Examine firewall and router configurations to verify that all other
# inbound and outbound traffic is specifically denied, for example by using an
# explicit “deny all” or an implicit deny after allow statement.

set -euo pipefail

source ${PCI_AUDIT_SCRIPT_DIR}/helpers.sh

PCI_AUDIT_OUTPUT_DIR=${PCI_AUDIT_TEMPDIR}/Req_${PCI_AUDIT_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}/${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

_info "--------------------------------------------------"
_info "Gathering information for Requirement ${PCI_AUDIT_REQUIREMENT}.${PCI_AUDIT_SUB_REQUIREMENT}.${PCI_AUDIT_SUB_SUB_REQUIREMENT}"
_info "--------------------------------------------------"

_info "--------------------------------------------------"
_info "Capturing Mod Security WAF Configuration"
_info "--------------------------------------------------"
cat /etc/apache2/mods-enabled/mod-security.conf >> ${PCI_AUDIT_OUTPUT_DIR}/${HOSTNAME}_ModSecurity_WAF_Config.txt 2<&1 || true

# Return to the parent directory
cd $(dirname $(get_script_dir))

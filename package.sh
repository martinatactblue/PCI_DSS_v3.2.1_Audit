#!/usr/bin/env bash

version=0.2.0
# Make sure all the scripts are executable
chmod 755 pci_audit.sh
find Req_3 -name "*.sh" | xargs chmod 755
find Req_8 -name "*.sh" | xargs chmod 755

tar cvf pci_audit_${version}.tar pci_audit.sh helpers.sh Req_3 Req_8

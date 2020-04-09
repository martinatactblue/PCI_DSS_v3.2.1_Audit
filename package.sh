#!/usr/bin/env bash

version=0.2.0
# Make sure all the scripts are executable
chmod 755 pci_audit.sh
tar cvf pci_audit_${version}.tar pci_audit.sh helpers.sh
for requirement in 3 6 8; do
    find Req_$requirement -name "*.sh" | xargs chmod 755
    tar rvf pci_audit_${version}.tar Req_$requirement
done

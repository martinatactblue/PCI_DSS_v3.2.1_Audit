#!/usr/bin/env bash

# Make sure all the scripts are executable
chmod 755 pci_audit.sh
find Req_8 -name "*.sh" | xargs chmod 755

tar cvf pci_audit.tar pci_audit.sh helpers.sh Req_8

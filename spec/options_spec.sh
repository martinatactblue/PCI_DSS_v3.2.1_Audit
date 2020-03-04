#shellcheck shell=sh

Describe "Option check"
  setup1() { PCI_AUDIT_SITENAME='TestSite'; }
  setup2() { PCI_AUDIT_ROOT_DIR="/tmp/Audit"; }
  setup3() { PCI_AUDIT_DATE=$(date +%m.%d.%y-%H.%M); }
  cleanup() { rm -r /tmp/Audit; }
  Before "setup1" "setup2" "setup3"
  After "cleanup"

  Describe "No options"
    It "Called with no arguments"
      When run source pci_audit.sh
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "/tmp/Audit" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End
  End
End

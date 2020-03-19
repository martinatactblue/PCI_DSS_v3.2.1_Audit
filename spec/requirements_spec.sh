#shellcheck shell=sh

Describe "Requirements Option check"
  setup1() { PCI_AUDIT_SITENAME='TestSite'; }
  setup2() { PCI_AUDIT_ROOT_DIR="/tmp/Audit"; }
  setup3() { PCI_AUDIT_DATE=$(date +%m.%d.%y-%H.%M); }
  cleanup() { if [[ -d ${PCI_AUDIT_ROOT_DIR} ]]; then rm -r ${PCI_AUDIT_ROOT_DIR}; fi; }
  Before "setup1" "setup2" "setup3"
  After "cleanup"

  Describe "Requirements option"
    It "Call with single option only (i.e 8)"
      When run source pci_audit.sh -r 8
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.4" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End
    Todo "Call with multiple options (i.e 6 and 8)"
    Todo "Call with multiple options (i.e 8.1.4 and 8.1.6)"
  End
End

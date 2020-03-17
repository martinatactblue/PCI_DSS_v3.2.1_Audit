#shellcheck shell=sh

Describe "Option check"
  setup1() { PCI_AUDIT_SITENAME='TestSite'; }
  setup2() { PCI_AUDIT_ROOT_DIR="/tmp/Audit"; }
  setup3() { PCI_AUDIT_DATE=$(date +%m.%d.%y-%H.%M); }
  cleanup() { if [[ -d ${PCI_AUDIT_ROOT_DIR} ]]; then rm -r ${PCI_AUDIT_ROOT_DIR}; fi; }
  Before "setup1" "setup2" "setup3"
  After "cleanup"

  Describe "No options"
    It "Call with no arguments"
      When run source pci_audit.sh
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.4" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End
  End

  Describe "Help option"
    It "Call with help option"
      When run source pci_audit.sh -h
      The first line of output should include "Usage"
      The status should eq 0
    End
  End

  Describe "Debug option"
    Todo "Call with debug option"
  End

  Describe "Invalid option"
    Todo "Call with invalid option"
  End

  Describe "Requirements option"
    It "Call with single requirements option only (i.e 8)"
      When run source pci_audit.sh -r 8
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.4" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End
    Todo "Call with multiple requirements options (i.e 6 and 8)"
    Todo "Call with multiple requirements options (i.e 8.1.4 and 8.1.6)"
  End
End

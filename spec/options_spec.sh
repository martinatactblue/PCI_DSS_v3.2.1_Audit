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
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End
  End

  Describe "Help option"
    It "Call with help option"
      When run source pci_audit.sh -h
      The first line of output should include "Usage:"
      The status should eq 0
    End
  End

  Describe "Debug option"
    It "Call with debug option"
      When run source pci_audit.sh -d 1
      The line 1 of stdout should include "DEBUG: Debugging enabled"
    End
    It "Call with option but no argument"
      When run source pci_audit.sh -d
      The first line of output should include "Usage:"
      The status should eq 1
    End
  End

  Describe "Invalid option"
    It "Call with invalid option"
      When run source pci_audit.sh -w
      The first line of output should include "Usage:"
      The status should eq 1
    End
  End

  Describe "Sitename option"
    It "Call with sitename"
      When run source pci_audit.sh -s PCI_AUDIT_SITENAME
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The file "${PCI_AUDIT_ROOT_DIR}/PCI_AUDIT_SITENAME-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/PCI_AUDIT_SITENAME-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/PCI_AUDIT_SITENAME-${HOSTNAME}-??.??.??-??.??.tgz"
    End
    It "Call with no argument"
      When run source pci_audit.sh -s
      The first line of output should include "Usage:"
      The status should eq 1
    End
  End

  Describe "Output option"
    It "Call with output option"
      When run source pci_audit.sh -o /tmp/TestAudit
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "/tmp/TestAudit" should be exist
    End
    It "Call with no argument"
      When run source pci_audit.sh -o
      The first line of output should include "Usage:"
      The status should eq 1
    End
  End
End

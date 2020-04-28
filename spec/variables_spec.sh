#shellcheck shell=sh

Describe "Variable check"

  Describe "Sitename is NOT set"
    It 'Sitename is not defined'
      The value "$PCI_AUDIT_SITENAME" should be blank
    End
  End

  Describe "Sitename is set"
    prepare() { PCI_AUDIT_SITENAME='TestSite'; }
    Before "prepare"

    It 'Sitename is defined'
      The value "$PCI_AUDIT_SITENAME" should be defined
      The variable PCI_AUDIT_SITENAME should equal "TestSite"
    End
  End

  Describe "Root directory is set"
    prepare() { PCI_AUDIT_ROOT_DIR='/tmp/TestAudit'; }
    Before "prepare"

    It 'Root directory is defined'
      The value "$PCI_AUDIT_ROOT_DIR" should be defined
      The variable PCI_AUDIT_ROOT_DIR should equal "/tmp/TestAudit"
    End
  End

  Describe "Called with no arguments"
    setup1() { PCI_AUDIT_SITENAME="TestSite"; }
    setup2() { PCI_AUDIT_ROOT_DIR="/tmp/TestAudit"; }
    setup3() { PCI_AUDIT_DATE=$(date +%m.%d.%y-%H.%M); }
    cleanup() { if [[ -d ${PCI_AUDIT_ROOT_DIR} ]]; then rm -r ${PCI_AUDIT_ROOT_DIR}; fi; }
    Before "setup1" "setup2" "setup3"
    After "cleanup"

    It "provides output"
      When run source pci_audit.sh
      The variable PCI_AUDIT_SITENAME should equal "TestSite"
      The line 1 of output should include "PCI DSS 3.2.1 Audit"
      # The stderr should include "WARNING: apt does not have a stable CLI interface"
    End
  End
End

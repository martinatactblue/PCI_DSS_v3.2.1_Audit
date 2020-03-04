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


  Describe "Called with no arguments"
    setup1() { PCI_AUDIT_SITENAME="TestSite"; }
    setup2() { PCI_AUDIT_ROOT_DIR="/tmp/Audit"; }
    setup3() { PCI_AUDIT_DATE=$(date +%m.%d.%y-%H.%M); }
    Before "setup1" "setup2" "setup3"

    It "provides output"
      When run source pci_audit.sh
      The variable PCI_AUDIT_SITENAME should equal "TestSite"
      The line 1 of output should include "PCI DSS 3.2.1 Audit"
    End
  End
End

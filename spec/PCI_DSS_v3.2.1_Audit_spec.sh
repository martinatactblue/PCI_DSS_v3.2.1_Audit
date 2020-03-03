Describe "PCI Audit"
  Describe "Helper script"
    Include ./helpers.sh

    Example "Print info message"
      When call _info "Test message"
      The output should include "INFO: Test message"
    End

    Example "Print warning message"
      When call _warn "Test message"
      The output should include "WARNING: Test message"
    End

    Example "Print debug message"
      When call _debug 0 "Test message"
      The output should include "DEBUG: Test message"
    End

    Example "Get script directory"
      When call get_script_dir
      The output should eq "$(pwd)"
    End
  End

  Describe "Variable check"
    Before "prepare"

    Describe "Sitename is NOT set"
      prepare() { :; }
      It 'Sitename is not defined'
        The value "$PCI_AUDIT_SITENAME" should be blank
      End
    End

    Describe "Sitename is set"
      prepare() { PCI_AUDIT_SITENAME='TestSite'; }
      It 'Sitename is defined'
        The value "$PCI_AUDIT_SITENAME" should be defined
        The variable PCI_AUDIT_SITENAME should equal "TestSite"
      End
    End
  End

  Describe "Option check"
    Before "prepare"

    Describe "Sitename and root directory are set"
      prepare() { PCI_AUDIT_SITENAME='TestSite'; PCI_AUDIT_ROOT_DIR="/tmp/Audit"; }
        It "Called with no arguments"
          When run source pci_audit.sh
          The first line of output should include "PCI DSS 3.2.1 Audit"
          The path "/tmp/Audit" should be exist
        End
      End
  End
End

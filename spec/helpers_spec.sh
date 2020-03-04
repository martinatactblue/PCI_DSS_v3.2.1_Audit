#shellcheck shell=sh

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

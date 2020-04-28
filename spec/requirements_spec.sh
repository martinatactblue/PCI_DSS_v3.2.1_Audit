Describe "Requirements Option check"
  setup1() { PCI_AUDIT_SITENAME='TestSite'; }
  setup2() { PCI_AUDIT_ROOT_DIR="/tmp/TestAudit"; }
  setup3() { PCI_AUDIT_DATE=$(date +%m.%d.%y-%H.%M); }
  cleanup() { if [[ -d ${PCI_AUDIT_ROOT_DIR} ]]; then rm -r ${PCI_AUDIT_ROOT_DIR}; fi; }
  Before "setup1" "setup2" "setup3"
  After "cleanup"

  Describe "Various requirements"
    It "Call with requirement 1"
      When run source pci_audit.sh -r 1
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_1/1.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_1/1.1/1.1.7" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_1/1.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_1/1.2/1.2.1" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End

    It "Call with requirement 2"
      When run source pci_audit.sh -r 2
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_2/2.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_2/2.1/2.1.b" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_2/2.2/2.2.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_2/2.2/2.2.3" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_2/2.2/2.2.5" should be exist
      # The stderr should include "WARNING: apt does not have a stable CLI interface"
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End

    It "Call with requirement 3"
      When run source pci_audit.sh -r 3
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_3" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_3/3.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_3/3.2/3.2.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_3/3.2/3.2.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_3/3.2/3.2.3" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End

    It "Call with requirement 6"
      When run source pci_audit.sh -r 6
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_6" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_6/6.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_6/6.2/6.2.b" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_6/6.4/6.4.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_6/6.4/6.4.4" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End

    It "Call with requirement 8"
      When run source pci_audit.sh -r 8
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.6" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2/8.2.3" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2/8.2.6" should be exist
      # The stderr should include "WARNING: apt does not have a stable CLI interface"
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End

    It "Call with requirement 10"
      When run source pci_audit.sh -r 10
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_10" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_10/10.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_10/10.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_10/10.2/10.2.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_10/10.2/10.2.4" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End

    It "Call with single sub-requirement only (i.e 8.1)"
      When run source pci_audit.sh -r 8.1
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.4" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2" should not be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End

    It "Call with single sub-sub-requirement only (i.e 8.1.5)"
      When run source pci_audit.sh -r 8.1.5
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.2" should not be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.4" should not be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.5" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2" should not be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End

    It "Call with multiple sub-sub-requirements (i.e 8.1.4 and 8.1.6)"
      When run source pci_audit.sh -r 8.1.4 -r 8.1.6
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.2" should not be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.4" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.5" should not be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.6" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2" should not be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End

    It "Call with sub-requirements and sub-sub-requirements (i.e 8.1 and 8.1.6)"
      When run source pci_audit.sh -r 8.1 -r 8.1.6
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.4" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.5" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.6" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2" should not be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End

    It "Call with multiple sub-requirements (i.e 8.1 and 8.2)"
      When run source pci_audit.sh -r 8.1 -r 8.2
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.6" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2/8.2.3" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2/8.2.6" should be exist
      # The stderr should include "WARNING: apt does not have a stable CLI interface"
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End

    It "Call with multiple sub-sub-requirements (i.e 8.1.3 and 8.2.1)"
      When run source pci_audit.sh -r 8.1.3 -r 8.2.1
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.2" should not be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.3" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.5" should not be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2/8.2.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2/8.2.3" should not be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2/8.2.5" should not be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End

    It "Call with multiple requirements (i.e 3 and 8)"
      When run source pci_audit.sh -r 8 -r 3
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.6" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2/8.2.3" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2/8.2.6" should be exist
      # The stderr should include "WARNING: apt does not have a stable CLI interface"
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_3" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_3/3.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_3/3.2/3.2.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_3/3.2/3.2.3" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End
  End

  Describe "No requirements"
    It "Call with no requirements"
      When run source pci_audit.sh
      The first line of output should include "PCI DSS 3.2.1 Audit"
      The dir "${PCI_AUDIT_ROOT_DIR}" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.1/8.1.6" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2/8.2.3" should be exist
      The dir "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}/Req_8/8.2/8.2.6" should be exist
      # The stderr should include "WARNING: apt does not have a stable CLI interface"
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should be exist
      The file "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}.tgz" should match pattern  "${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-??.??.??-??.??.tgz"
    End
  End
End

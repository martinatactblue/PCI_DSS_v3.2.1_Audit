# PCI_DSS_v3.2.1_Audit
Gathers evidence from Linux systems for PCI Compliance

# Description
This is an auditing tool to gather evidence for PCI compliance. It is designed
to be run by system adminstrators who want to check configuration files and/or
PCI auditors against systems they have been engaged to assess for PCI Compliance.

It is an opiniated evidence gathering tool, in that it is currently designed to
gather evidence for Ubuntu systems.

# Requirements/Assumptions
The tool is designed to be run on physical/virtual systems. It is not meant to
be run on containers.

Some evidence gathering requires use of **sudo**. It is assumed that prior to
running the tool, you "prime the sudo pump" so as to not require entering your
password for every sudo command.

# Packaging and Deployment

To package the tool, run the **package.sh** script. This will create a GZIP tar
file containing all the scripts needed to run the audit. The package can be
copied to the target system and extracted into any directory.

Once the audit has been completed a second GZIP tar file is created containing
all the requested evidence.

# Usage
```
./pci_audit.sh [-h] | [-s sitename] [[-r requirement] ...] [-o output_directory]
  [-d debug_level]
```

# Command Options
Options can be supplied in any order.

## Sitename
The `sitename` option, `-s` is used as part of the specification of the GZIP tar
file that contains the gathered evidence. By default, the filename is composed
of the sitename, the hostname, and the date of the audit. If no site name is
provided (see the Variables section below), you will be prompted for one. The
sitename is typically the name of the organization being audited.

## Requirement(s)
The requirements option is used to specify the requirement for which you wish to
gather data.
The requirements option can be repeated any number of times. A requirement can
consist of a top-level requirement (e.g 8), a secondary requirement (e.g 8.1),
or a tertiary requirement (e.g. 8.1.4). Any combination of requirements is
allowed.

**Note:** Providing a top-level requirement along with the secondary or tertiary
requirement of the same group (i.e. supplying 8 and 8.1, or 8 and 8.1.3) will
result in evidence collection for all secondary and tertiary requirements being
gathered under requirwement 8, for example. Likewise, requesting requirements 8.1
and 8.1.3 will result in data collection for all the tertiary requirements under
requirement 8.1. Conversely, requesting requirements 2.2.5 and 8.2.1 will result
in data collection for only those two requirements.

** If no requirements are specified, the tool will gather evidence for all the
top-level, secondary, and tertiary requirements that the tool covers.**

# Variables
If you wish to override the default behavior of the tool, there are a number of
variables that can be used for this purpose. The variables can either be preset
in the environment or can be pre-pended to the command line when invoking the
tool.
## PCI_AUDIT_DATE
The PCI_AUDIT_DATE is a component of the generated filename for the GZIP tar
file name used to store evidence. It is also in the name of the directory used
to store the  file. By default it is of the date format `%m.%d.%y-%H.%M` and is
set to the invocation time of the script.
## PCI_AUDIT_ROOT_DIR
The PCI_AUDIT_ROOT_DIR is the top of a directory tree where the evidence files
are gathered and the GZIP tar file is created. If not specified, it defaults to
creating a directory named `Audit` in the directory which contains the
`pci_audit` script.
## PCI_AUDIT_SITENAME
The PCI_AUDIT_SITENAME is a component of the generated filename for the GZIP tar
file name used to store evidence. It is also in the name of the directory used
to store the  file. If not set, you will be prompted to enter a sitename.
## PCI_AUDIT_DEBUG_LEVEL
## PCI_AUDIT_ARCHIVE_DEBUG_LEVEL

# Testing
The tool can be tested via the `shellspec` test tool. If shellspec is installed,
the full test suite can be run by executing `shellspec -s /bin/bash -f d`.
Tests are located in the `spec` directory.

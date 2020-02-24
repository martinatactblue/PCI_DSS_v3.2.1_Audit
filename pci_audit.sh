#!/usr/bin/env bash

# PCI_Audit - Checks Linux systems for PCI Compliance

set -euo pipefail

PCI_AUDIT_VERSION=0.1.0
PCI_AUDIT_DATE=$(date +%m.%d.%y-%H.%M)
export DEBUG_LEVEL=${PCI_AUDIT_DEBUG_LEVEL:-0}
export ARCHIVE_DEBUG_LEVEL=${PCI_AUDIT_ARCHIVE_DEBUG_LEVEL:-2}
PCI_AUDIT_SITENAME=${PCI_AUDIT_SITENAME:-"notset"}

source ./helpers.sh

PCI_AUDIT_ROOT_DIR=$(get_script_dir)/Audit

get_site_name() {
    if [[ ${PCI_AUDIT_SITENAME} = "notset" ]]; then
        echo "Enter Site Name:"
        read PCI_AUDIT_SITENAME
    fi
}

create_archive() {
    if [[ ${DEBUG_LEVEL} -ge ${ARCHIVE_DEBUG_LEVEL} ]]; then
        tar czvf ${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_REQUIREMENT}-${PCI_AUDIT_DATE}.tgz ${PCI_AUDIT_REQUIREMENT}
    else
        tar czf ${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_REQUIREMENT}-${PCI_AUDIT_DATE}.tgz ${PCI_AUDIT_REQUIREMENT}
    fi
}

##### MAIN

clear
echo "                 PCI DSS 3.2.1 Audit v${PCI_AUDIT_VERSION}  "
echo "------------------------------------------------------------"

get_site_name

# Create a temp directory
# If there are issues with directory creation
export PCI_AUDIT_TEMPDIR=${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}
if [ ! -d "$PCI_AUDIT_ROOT_DIR" ]; then
        mkdir "$PCI_AUDIT_ROOT_DIR"
fi

if [ -d "$PCI_AUDIT_TEMPDIR" ]; then
	_error "${PCI_AUDIT_TEMPDIR} already exists. Rename the folder to prevent data loss"
    exit 1
else
    mkdir ${PCI_AUDIT_TEMPDIR}
fi

_debug 1 "Current location: $(get_script_dir)"
_debug 1 "Current script: $0"

export PCI_AUDIT_SCRIPT_DIR=$(get_script_dir)

export PCI_AUDIT_REQUIREMENT=Req_8
if [[ ! -d ${PCI_AUDIT_TEMPDIR}/${PCI_AUDIT_REQUIREMENT} ]]; then
    mkdir ${PCI_AUDIT_TEMPDIR}/${PCI_AUDIT_REQUIREMENT}
fi

cd ${PCI_AUDIT_REQUIREMENT}
./${PCI_AUDIT_REQUIREMENT}.sh
cd $(dirname $(get_script_dir))

_debug 1 "Current location: $(get_script_dir)"

cd ${PCI_AUDIT_ROOT_DIR}/${PCI_AUDIT_SITENAME}-${HOSTNAME}-${PCI_AUDIT_DATE}
create_archive
cd $(dirname ${PCI_AUDIT_ROOT_DIR})

_debug 1 "Current location: $(get_script_dir)"

_info "Audit archives are located in ${PCI_AUDIT_ROOT_DIR}"

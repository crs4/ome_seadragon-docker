#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv/bin:$PATH"
python=/opt/omero/web/venv/bin/python
omero=/opt/omero/web/OMERO.web/bin/omero

ROOTPASS="${ROOTPASS:-omero}"
OMEROHOST="${OMEROHOST:-}"
OMEROPORT="${OMEROPORT:-4064}"

# wait until OMERO.server accepts connections
echo 'Checking OMERO.server at "$OMEROHOST"'
until $python $omero group list --server "$OMEROHOST" --port "$OMEROPORT" --user root --password "$ROOTPASS" > /dev/null 2>&1 ; do
    echo "OMERO.server not ready, waiting...";
    sleep 5
done
echo "OMERO.server ready, start configuration of OMERO.web"

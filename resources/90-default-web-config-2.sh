#!/bin/bash
# Override omero.web.server_list with OMEROHOST and or OMEROPORT if set
# NOTE: this overrides step 60-default-web-config.sh of openmicroscopy/omero-web docker image

set -eu

export PATH="/opt/omero/web/venv/bin:$PATH"
python=/opt/omero/web/venv/bin/python
omero=/opt/omero/web/OMERO.web/bin/omero

OMEROHOST=${OMEROHOST:-}
OMEROPORT=${OMEROPORT:-}

if [ -n "$OMEROHOST" ]; then
    if [ -n "$OMEROPORT" ]; then
        $python $omero config set omero.web.server_list "[[\"$OMEROHOST\", \"$OMEROPORT\", \"omero\"]]"
    else 
        $python $omero config set omero.web.server_list "[[\"$OMEROHOST\", 4064, \"omero\"]]"
    fi
else
    if [ -n "$OMEROPORT" ]; then
        $python $omero config set omero.web.server_list "[[\"localhost\", \"$OMEROPORT\", \"omero\"]]"
    fi
fi
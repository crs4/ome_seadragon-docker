#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv3/bin:$PATH"
python=/opt/omero/web/venv3/bin/python
omero=/opt/omero/web/venv3/bin/omero

OME_SEADRAGON_COOKIE="${OME_SEADRAGON_COOKIE:-ome_seadragon_web}"

echo "Enable ome_seadragon plugin"
$python $omero config append omero.web.apps '"ome_seadragon"'

echo "Override OMERO.web default cookie"
$python $omero config set omero.web.session_cookie_name "$OME_SEADRAGON_COOKIE"

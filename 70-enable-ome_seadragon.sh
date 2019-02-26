#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv/bin:$PATH"
python=/opt/omero/web/venv/bin/python
omero=/opt/omero/web/OMERO.web/bin/omero
cd /opt/omero/web

echo "Enable ome_seadragon plugin"
exec $python $omero config append omero.web.apps '"ome_seadragon"'
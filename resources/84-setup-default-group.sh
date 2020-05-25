#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv3/bin:$PATH"
python=/opt/omero/web/venv3/bin/python
omero=/opt/omero/web/venv3/bin/omero

DEFAULT_OME_GROUP="${DEFAULT_OME_GROUP:-}"

if [ -n "$DEFAULT_OME_GROUP" ]; then
    $python $omero config set omero.web.ome_seadragon.search.default_group "$DEFAULT_OME_GROUP"
fi

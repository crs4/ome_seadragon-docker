#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv3/bin:$PATH"
python=/opt/omero/web/venv3/bin/python
omero=/opt/omero/web/venv3/bin/omero

IMAGES_REPOSITORY="${IMAGES_REPOSITORY:-/OMERO/}"
IMAGES_FOLDER="${IMAGES_FOLDER:-}"
MIRAX_FOLDER="${MIRAX_FOLDER:-}"

$python $omero config set omero.web.ome_seadragon.repository "$IMAGES_REPOSITORY"
if [ -n "$IMAGES_FOLDER" ]; then
    $python $omero config set omero.web.ome_seadragon.images_folder "$IMAGES_FOLDER"
fi

if [ -n "$MIRAX_FOLDER" ]; then
    $python $omero config set omero.web.ome_seadragon.default_mirax_folder "$MIRAX_FOLDER"
fi

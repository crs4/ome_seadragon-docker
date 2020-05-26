#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv3/bin:$PATH"
python=/opt/omero/web/venv3/bin/python
omero=/opt/omero/web/venv3/bin/omero

# tiles rendering engines
TILES_PRIMARY_ENGINE="${TILES_PRIMARY_ENGINE:-openslide}"

if [ $TILES_PRIMARY_ENGINE == "openslide" ]; then
    TILES_SECONDARY_ENGINE="omero"
elif [ $TILES_PRIMARY_ENGINE == "omero" ]; then
    TILES_SECONDARY_ENGINE="openslide"
else
    echo "ERROR: $$TILES_PRIMARY_ENGINE is not a valid engine, using openslide as default tiles rendering engine"
    TILES_PRIMARY_ENGINE="openslide"
    TILES_SECONDARY_ENGINE="omero"
fi

echo "Setting $TILES_PRIMARY_ENGINE as primary tiles rendering engine and $TILES_SECONDARY_ENGINE as secondary"

$python $omero config set omero.web.ome_seadragon.tiles.primary_rendering_engine "$TILES_PRIMARY_ENGINE"
$python $omero config set omero.web.ome_seadragon.tiles.secondary_rendering_engine "$TILES_SECONDARY_ENGINE"

# thumbnails rendering engines
THUMBNAILS_PRIMARY_ENGINE="${THUMBNAILS_PRIMARY_ENGINE:-omero}"

if [ $THUMBNAILS_PRIMARY_ENGINE == "openslide" ]; then
    THUMBNAILS_SECONDARY_ENGINE="omero"
elif [ $THUMBNAILS_PRIMARY_ENGINE == "omero" ]; then
    THUMBNAILS_SECONDARY_ENGINE="openslide"
else
    echo "ERROR: $$TILES_PRIMARY_ENGINE is not a valid engine, using omero as default thumbnails rendering engine"
    THUMBNAILS_PRIMARY_ENGINE="openslide"
    THUMBNAILS_SECONDARY_ENGINE="omero"
fi

echo "Setting $THUMBNAILS_PRIMARY_ENGINE as primary thumbnails rendering engine and $THUMBNAILS_SECONDARY_ENGINE as secondary"

$python $omero config set omero.web.ome_seadragon.thumbnails.primary_rendering_engine "$THUMBNAILS_PRIMARY_ENGINE"
$python $omero config set omero.web.ome_seadragon.thumbnails.secondary_rendering_engine "$THUMBNAILS_SECONDARY_ENGINE"
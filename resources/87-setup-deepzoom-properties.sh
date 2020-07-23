#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv3/bin:$PATH"
python=/opt/omero/web/venv3/bin/python
omero=/opt/omero/web/venv3/bin/omero

TILES_OVERLAP="${TILES_OVERLAP:-1}"
TILES_FORMAT="${TILES_FORMAT:-jpeg}"
JPEG_TILES_QUALITY="${JPEG_TILES_QUALITY:-90}"
SLIDE_LIMIT_BOUNDS="${SLIDE_LIMIT_BOUNDS:-True}"
TILES_SIZE="${TILES_SIZE:-256}"

if [ -n "$TILES_OVERLAP" ]; then
    echo "Setting tiles overlap to $TILES_OVERLAP"
    $python $omero config set omero.web.ome_seadragon.deepzoom.overlap "$TILES_OVERLAP"
fi

if [ -n "$TILES_FORMAT" ]; then
    echo "Setting tiles format to $TILES_FORMAT"
    $python $omero config set omero.web.ome_seadragon.deepzoom.format "$TILES_FORMAT"
fi

if [ -n "$JPEG_TILES_QUALITY" ]; then
    TF=$($python $omero config get omero.web.ome_seadragon.deepzoom.format)
    if [ $TF=="jpeg" ]; then
        echo "Setting JPEG tiles quality to $JPEG_TILES_QUALITY"
        $python $omero config set omero.web.ome_seadragon.deepzoom.jpeg_tile_quality $JPEG_TILES_QUALITY
    else
        echo "Tiles format is $TF, no need to set JPEG quality"
    fi
fi

if [ -n "$SLIDE_LIMIT_BOUNDS" ]; then
    echo "Setting slide limit bounds to $SLIDE_LIMIT_BOUNDS"
    $python $omero config set omero.web.ome_seadragon.deepzoom.limit_bounds $SLIDE_LIMIT_BOUNDS
fi

if [ -n "$TILES_SIZE" ]; then
    echo "Setting tiles size to $TILES_SIZE pixels"
    $python $omero config set omero.web.ome_seadragon.deepzoom.tile_size $TILES_SIZE
fi

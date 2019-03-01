#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv/bin:$PATH"
python=/opt/omero/web/venv/bin/python
omero=/opt/omero/web/OMERO.web/bin/omero

REDISHOST="${REDISHOST:-}"
REDISPORT="${REDISPORT:-6379}"
REDISDB="${REDISDB:-0}"
CACHE_EXPIRE_TIME="${CACHE_EXPIRE_TIME:-'{\"hours\": 8}'}"

if [ -n "$REDISHOST" ]; then
    echo "Setup REDIS cache"
    $python $omero config set omero.web.ome_seadragon.images_cache.cache_enabled True
    $python $omero config set omero.web.ome_seadragon.images_cache.driver 'redis'
    $python $omero config set omero.web.ome_seadragon.images_cache.host "$REDISHOST"
    $python $omero config set omero.web.ome_seadragon.images_cache.port "$REDISPORT"
    $python $omero config set omero.web.ome_seadragon.images_cache.database "$REDISDB"
    $python $omero config set omero.web.ome_seadragon.images_cache.expire_time "$CACHE_EXPIRE_TIME"
else
    echo "REDIS cache not enabled"
    $python $omero config set omero.web.ome_seadragon.images_cache.cache_enabled False
fi

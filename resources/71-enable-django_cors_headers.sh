#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv/bin:$PATH"
python=/opt/omero/web/venv/bin/python
omero=/opt/omero/web/OMERO.web/bin/omero

CORS_WHITELIST="${CORS_WHITELIST:-}"

$python $omero config append omero.web.apps '"corsheaders"'
$python $omero config append omero.web.middleware '{"index": 0.5, "class": "corsheaders.middleware.CorsMiddleware"}'
$python $omero config append omero.web.middleware '{"index": 10, "class": "corsheaders.middleware.CorsPostCsrfMiddleware"}'

if [ -n "$CORS_WHITELIST" ]; then
    echo "Setup CORS whitelist"
    $python $omero config set omero.web.cors_origin_allow_all False
    $python $omero config set omero.web.cors_origin_whitelist $CORS_WHITELIST
else
    echo "No CORS whitelist, ALLOWING ALL HOSTS"
    $python $omero config set omero.web.cors_origin_allow_all True
fi

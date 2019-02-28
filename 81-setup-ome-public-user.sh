#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv/bin:$PATH"
python=/opt/omero/web/venv/bin/python
omero=/opt/omero/web/OMERO.web/bin/omero

OME_PUBLIC_USER_NAME="${OME_PUBLIC_USER_NAME:-ome_public}"
OME_PUBLIC_USER_PASS="${OME_PUBLIC_USER_PASS:-omero}"

echo "Setup OMERO public user"
$python $omero config set omero.web.public.enabled True
$python $omero config set omero.web.public.user "$OME_PUBLIC_USER_NAME"
$python $omero config set omero.web.public.password "$OME_PUBLIC_USER_PASS"
$python $omero config set omero.web.public.url_filter '^/ome_seadragon'
$python $omero config set omero.web.public.server_id 1

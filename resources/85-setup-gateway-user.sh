#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv3/bin:$PATH"
python=/opt/omero/web/venv3/bin/python
omero=/opt/omero/web/venv3/bin/omero

ROOTPASS="${ROOTPASS:-omero}"
OMEROHOST="${OMEROHOST:-}"
OMEROPORT="${OMEROPORT:-4064}"
GW_USER_NAME="${GW_USER_NAME:-}"
GW_USER_PASS="${GW_USER_PASS:-}"
GW_USER_GROUP="${GW_USER_GROUP:-ome_gw_data}"

if [ -n "$GW_USER_NAME" -a -n "$GW_USER_PASS" ]; then
    echo "Create ome_seadragon_gateway default user and related group"
    # create a group for the ome_seadragon_gateway default user
    $python $omero group add --ignore-existing --server "$OMEROHOST" --port "$OMEROPORT" --user root \
                             --password "$ROOTPASS" --type read-only "$GW_USER_GROUP"
    # create ome_seadragon_gateway default user
    $python $omero user add --ignore-existing --server "$OMEROHOST" --port "$OMEROPORT" --user root \
                            --password "$ROOTPASS" "$GW_USER_NAME" OME GATEWAY \
                            --group-name "$GW_USER_GROUP" --userpassword "$GW_USER_PASS"
else
    echo "Missing username and/or password for ome_seadragon_gateway user, no default user will be created"
fi

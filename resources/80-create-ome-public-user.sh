#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv3/bin:$PATH"
python=/opt/omero/web/venv3/bin/python
omero=/opt/omero/web/venv3/bin/omero

ROOTPASS="${ROOTPASS:-omero}"
OMEROHOST="${OMEROHOST:-}"
OMEROPORT="${OMEROPORT:-4064}"
OME_PUBLIC_GROUP="${OME_PUBLIC_GROUP:-ome_public_data}"
OME_PUBLIC_USER_NAME="${OME_PUBLIC_USER_NAME:-ome_public}"
OME_PUBLIC_USER_PASS="${OME_PUBLIC_USER_PASS:-omero}"

# create a group for the public user
echo "Creating default public user group"
$python $omero group add --ignore-existing --server "$OMEROHOST" --port "$OMEROPORT" --user root \
                         --password "$ROOTPASS" --type read-only "$OME_PUBLIC_GROUP"

#create public user
echo "Creating public user"
$python $omero user add --ignore-existing --server "$OMEROHOST" --port "$OMEROPORT" --user root \
                        --password "$ROOTPASS" "$OME_PUBLIC_USER_NAME" OME PUBLIC \
                        --group-name "$OME_PUBLIC_GROUP" --userpassword "$OME_PUBLIC_USER_PASS"

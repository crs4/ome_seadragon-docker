#!/bin/bash

set -eu

export PATH="/opt/omero/web/venv/bin:$PATH"
python=/opt/omero/web/venv/bin/python
omero=/opt/omero/web/OMERO.web/bin/omero

ROOTPASS="${ROOTPASS:-omero}"
OMEROHOST="${OMEROHOST:-}"
OME_PUBLIC_GROUP="${OME_PUBLIC_GROUP:-ome_public_data}"
OME_PUBLIC_USER_PASS="${OME_PUBLIC_USER_PASS:-omero}"

# create a group for the public user
echo "Creating default public user group"
exec $python $omero group add --ignore-existing --server "$OMEROHOST" --user root \
                              --password "$ROOTPASS" --type read-only "$OME_PUBLIC_GROUP"

#create public user
echo "Creating public user"
exec $python $omero user add --ignore-existing --server "$OMEROHOST" --user root \
                             --password "$ROOTPASS" ome_public OME PUBLIC \
                             --group-name "$OME_PUBLIC_GROUP" --userpassword "$OME_PUBLIC_USER_PASS"

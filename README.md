# ome_seadragon-docker

A Docker image based on [openmicroscopy/omero-web](https://hub.docker.com/r/openmicroscopy/omero-web/) with an already installed ome_seadragon plugin.

## Requirements

A running [openmicroscopy/omero-server](https://hub.docker.com/r/openmicroscopy/omero-server).

It is strongly encouraged the usage of the [crs4/ome_seadragon-nginx](https://hub.docker.com/repository/docker/crs4/ome_seadragon-nginx) Docker image as web server.

## Configuration

The server can be configured using the following environment variables:

---

### OMERO server

**OMEROHOST** the OMERO server hosting the data

**OMEROPORT** *(default 4064)* the port of the OMERO server

**ROOTPASS** *(default omero)* root password for OMERO server

**IMAGES_REPOSITORY** *(default /OMERO/)*

---

### OMERO web server

**OME_SEADRAGON_COOKIE** *(default ome_seadragon_web)* the cookie used by OMERO web server

For more details on OMERO web configuration, please refere to the [official documentation](https://hub.docker.com/r/openmicroscopy/omero-web/)

---

### Images repository

**IMAGES_FOLDER** *(default None)* the folder containing the images managed by OMERO server, only needed if different than default one which is `$IMAGES_REPOSITORY/ManagedRepository/`

---

### OMERO public user and group

**OME_PUBLIC_GROUP** *(default ome_public_data)* the default group for OMERO public user

**OME_PUBLIC_USER_NAME** *(default ome_public)* OMERO default public user

**OME_PUBLIC_USER_PASS** *(default omero)* OMERO public user's default password

**OME_PUBLIC_URL_FILTER** *(default ^/ome_seadragon)* the default URL filter used in combination with OMERO public user, for further details please check [OMERO server documentation](https://docs.openmicroscopy.org/omero/5.6.0/sysadmins/public.html)

**DEFAULT_OME_GROUP** *(default None)* if OMERO public user belongs to more than one group, this is the default group to search for images, projects, datasets and tags

---

### REDIS cache

**REDISHOST** *(default None)* Redis host that will be used as cache server. If not specified, cache won't be enabled.

**REDISPORT** *(default 6379)* Redis server's port

**REDISDB** *(default 0)* Redis server's database ID

**CACHE_EXPIRE_TIME** *(default '{"hours": 8}')* the expire time for tiles and thumbnails stored in cache. This value is expressed as a JSON string and one or a combination of the following keys are accepted `days` `hours` `minutes` and `seconds`

---

### [ome_seadragon_gateway](https://github.com/crs4/ome_seadragon_gateway)

**GW_USER_NAME** *(default None)* OMERO user used to login if an ome_seadragon_gateway server is enabled

**GW_USER_PASS** *(default None)* password for `GW_USER_NAME` user

**GW_USER_GROUP** *(default ome_gw_data)* the default group for the `GW_USER_NAME` user. If it doen't exits, it will be automatically created.

**Important**: if `GW_USER_NAME` user doesn't exist in the system but both `GW_USER_NAME` and `GW_USER_PASS` are provided, it will be automatically created and associated to `GW_USER_GROUP` group

---

### Rendering engines

**Important**: only two rendering engines are supported at the moment `openslide` and `omero`. If different values are specified, this will result in an error.

**TILES_PRIMARY_ENGINE** *(default openslide)* the primary tiles rendering engine. If `openslide` is used as primary, `omero` will be used as secondary engine and vice versa

**THUMBNAILS_PRIMARY_ENGINE** *(default openslide)* the primary thumbnails rendering engine. If `openslide` is used as primary, `omero` will be used as secondary engine and vice versa

---

### DeepZoom properties

**TILES_OVERLAP** *(default 1)* specify how many pixels each tile will overlap with the next ones

**TILES_FORMAT** *(default jpeg)* the file of the tiles. It can be `jpeg` or `png`

**JPEG_TILES_QUALITY** *(default 90)* the quality of JPEG compressed tiles. Only applied if `jpeg` is set for `TILES_FORMAT` variable

**SLIDE_LIMIT_BOUNDS** *(default True)* if True, only render only the non-empty slide region. This only applies when rendering slides using `openslide` engine (regardless of whether it's primary or secondary)

**TILES_SIZE** *(default 256)* the size in pixels of a tile's border. Tiles are always retrieved as squares

---

## Examples

A Docker compose example to run a complete ome_seadragon stack can be found [here](https://github.com/lucalianas/ome_seadragon_compose)
#!/bin/bash

# base location
#BASE_DIR="/Users/username/src"
BASE_DIR="/Users/json/src/purple.mcserver.io"

# location of the world files
SERVER_DIR="$BASE_DIR/papermc"

# location of the generated map files
EXPORT_DIR="$BASE_DIR/overviewer/maps"

# location of optional texture packs
TEXTURE_DIR="$BASE_DIR/overviewer/textures"

# custom config dir
CONFIG_DIR="$BASE_DIR/overviewer/config"

genPoi () {
  docker run \
    --rm \
    -v $SERVER_DIR:/tmp/server/:ro \
    -v $EXPORT_DIR/:/tmp/export/:rw \
    -v $TEXTURE_DIR/:/tmp/textures/:ro \
    -v $CONFIG_DIR/:/tmp/config/:ro \
    -e overviewerParams="--genpoi" \
    -it marctv/minecraft-overviewer
}

genMaps () {
  docker run \
    --rm \
    -v $SERVER_DIR:/tmp/server/:ro \
    -v $EXPORT_DIR/:/tmp/export/:rw \
    -v $TEXTURE_DIR/:/tmp/textures/:ro \
    -v $CONFIG_DIR/:/tmp/config/:ro \
    -it marctv/minecraft-overviewer
}

# run the docker image to generate POI
#genPoi

# run the docker image to generate maps
# genMaps

# run everything consecutively
genPoi && genMaps

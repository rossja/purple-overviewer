#!/bin/bash

# base location
BASE_DIR="/Users/json/src"

# location of the world files
WORLD_DIR="$BASE_DIR/purple"

# location of the overviewer dir
OVERVIEW_DIR="$BASE_DIR/purple-overviewer"

# where to put the generated map files
EXPORT_DIR="$OVERVIEW_DIR/maps"

# location of optional texture packs
TEXTURE_DIR="$OVERVIEW_DIR/textures"

# custom config dir
CONFIG_DIR="$BASE_DIR/purple-overviewer/config"

genPoi () {
  docker run \
    --rm \
    -v $WORLD_DIR:/tmp/server/:ro \
    -v $EXPORT_DIR/:/tmp/export/:rw \
    -v $TEXTURE_DIR/:/tmp/textures/:ro \
    -v $CONFIG_DIR/:/tmp/config/:ro \
    -e overviewerParams="--genpoi" \
    -it marctv/minecraft-overviewer
}

genMaps () {
  docker run \
    --rm \
    -v $WORLD_DIR:/tmp/server/:ro \
    -v $EXPORT_DIR/:/tmp/export/:rw \
    -v $TEXTURE_DIR/:/tmp/textures/:ro \
    -v $CONFIG_DIR/:/tmp/config/:ro \
    -it marctv/minecraft-overviewer
}

# run the docker image to generate POI
#genPoi && echo -e "\nPOI created!\n"

# run the docker image to generate maps
# genMaps && echo -e "\nMaps created!\n"

# run everything consecutively
genPoi && genMaps && echo -e "\nMaps and POI created!\n"

global escape
from cgi import escape

worlds["purple"] = "/tmp/server/world/"
worlds["purple_nether"] = "/tmp/server/world_nether/"

# default textures
texturepath = "/tmp/overviewer/client.jar"

# custom textures
# texturepath = "/tmp/textures/ChromaHills-128x-1.15-v1.zip"
# texturepath = "/tmp/textures/Monsterley_128_15_200405.zip"

# output directory
outputdir = "/tmp/export/"

processes = 2
defaultzoom = 5
my_crop = (-1200, -1600, 900, 400)

def playerIcons(poi):
    if poi['id'] == 'Player':
        poi['icon'] = "https://freezion.com/assets/steve.png"
        return "Last known location for %s" % poi['EntityId']

def playerSpawns(poi):
    if poi['id']=='PlayerSpawn':
        poi['icon'] = "https://freezion.com/assets/bed.png"
        return "Spawn for %s" % poi['EntityId']

def signFilter(poi):
    if poi['id'] == 'Sign' or poi['id'] == 'minecraft:sign':
        poi['icon'] = "https://freezion.com/assets/sign.png"
        text = "\n".join(map(escape, [poi['Text1'], poi['Text2'], poi['Text3'], poi['Text4']]))
        if text.__contains__('...'):
            text.replace('...', '')
        # if text.__eq__(''):
        #     return # return nothing if the sign is blank (because farms)
        # else:
        #     return text # otherwise return the content of the sign
        return text

def chestFilter(poi):
    if poi['id'] == 'Chest' or poi['id'] == 'minecraft:chest':
        return "Chest with %d items" % len(poi['Items'])

markerList = [
    dict(name="Players", filterFunction=playerIcons),
    dict(name="Beds", filterFunction=playerSpawns),
    dict(name="Signs", filterFunction=signFilter),
    #dict(name="Chests", filterFunction=chestFilter)
]

renders["day_complete_smooth"] = {
    'world': 'purple',
    'title': 'Day',
    'rendermode': 'smooth_lighting',
    "dimension": "overworld",
    # 'crop': my_crop,
    'markers': markerList
}

# renders["night_complete"] = {
#     'world': 'purple',
#     'title': 'Night',
#     'rendermode': 'smooth_night',
#     "dimension": "overworld",
#     'markers': markerList
# }

renders["nether"] = {
    "world": "purple_nether",
    "title": "Nether",
    "rendermode": "nether",
    "dimension": "nether",
    # 'crop': (-200, -200, 200, 200)
}

# Import the Observers
from .observer import MultiplexingObserver, ProgressBarObserver, JSObserver

# Construct the ProgressBarObserver
pbo = ProgressBarObserver()

# Construct a basic JSObserver
jsObserver = JSObserver(outputdir, 30)

# Set the observer to a MultiplexingObserver
observer = MultiplexingObserver(pbo, jsObserver)

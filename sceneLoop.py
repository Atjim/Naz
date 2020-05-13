# file: sceneLoop.py
# Loops through scenes
# This script will loop through the scenes for ever
# User interaction is needed for the scenes to quit playing
# Export all sketches into apps
# Put all apps in the same folder in the order you want them
# Navigate to this file via prompt/terminal
# Make this file executable by running: chmod +x sceneLoop.py
# Run script by running: ./sceneLoop.py

import os
import subprocess
import glob
cwd = os.getcwd()
print "Running all apps in " + cwd
while True:
    for name in glob.glob('*.app'):
        print name
        subprocess.call(['open', '-W', name])

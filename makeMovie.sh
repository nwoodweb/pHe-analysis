#!/bin/sh
# WOOD-NT (contact@nwoodweb.xyz)
# Go to directory with tiff files and create a movie using
# this command.
# You should keep each tiff image in its own directory for 
# organization. All files in the current directory will 
# be used for creation of the MP4 video
#
# MIT LICENSE

ffmpeg -framerate 6 -pattern_type glob -i "*.tif" output.mp4

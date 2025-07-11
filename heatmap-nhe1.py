# NATHAN WOOD (contact@nwoodweb.xyz) 2025
# Convert NHE1 grayscale pixel intensity to heatmap with viridis pallette
# MIT LICENSE

# NEEDS WORK

import tifffile
import cv2
import numpy as np
import matplotlib.pyplot as plt
import glob
import os

# define input and output directories
inputDir = os.path.expanduser("/data/nhe1/")
outputDir = os.path.expanduser("/data/nhe1/data")

# iterate through
for img in sorted(glob(os.path.join(inputDir,"*.tif"))):
    print(img)
    image = tifffile.imread(img)
    # Choose viridis pallette https://matplotlib.org/stable/users/explain/colors/colormaps.html
    viridis = plt.get_cmap('viridis')
    heatMap = (viridis(image) 

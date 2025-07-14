# 11 JULY 2025 WOOD-NT (contact@nwoodweb.xyz)
#
# MIT LICENSE

import tifffile
import numpy as np
import matplotlib.pyplot as plt
from skimage import exposure, img_as_ubyte
from skimage.restoration import denoise_tv_chambolle
from skimage.filters import gaussian
from skimage.morphology import opening, disk
import cv2 # OpenCV for video writing

# load image
image = tifffile.imread('./ph7-01-nhe1-corrected-set.tif')

viridis_cmap = plt.get_cmap('viridis')
zStack = image.shape[0] 
frameWidth = image.shape[2]
frameHeight = image.shape[1]
frameRate = 4

# save as AVI
fourcc = cv2.VideoWriter_fourcc(*'MJPG') 
out = cv2.VideoWriter('./test.avi', fourcc, frameRate, (frameWidth, frameHeight)) 

processedSlices = []
# iterate through each optical section
for i in range(zStack):
    current = image[i,:,:]

    #progress bar
    if i % 10 == 0: 
        print("Z Section: {} out of {}".format(i,zStack))

    # histogram equalization
    normalized = exposure.rescale_intensity(current,in_range='image')

    # convert to 8 bit unsigned
    reduced = img_as_ubyte(normalized)
    # assign viridis colormap
    colorMap = viridis_cmap(reduced / 255.0)[:,:,:3]
    
    videoFrame = (colorMap * 255).astype(np.uint8)
    videoFrame = cv2.cvtColor(videoFrame, cv2.COLOR_RGB2BGR)
    
    # save as video frame
    out.write(videoFrame)

# save video file 
out.release()

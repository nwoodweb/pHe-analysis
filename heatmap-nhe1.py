# 11 JULY 2025 WOOD-NT (contact@nwoodweb.xyz)
#
# MIT LICENSE

import tifffile
import numpy as np
import matplotlib.pyplot as plt
from skimage import exposure, img_as_ubyte
from skimage.restoration import denoise_tv_chambolle
from skimage.filters import gaussian



# load image
image = tifffile.imread('./ph7-01-nhe1-corrected-set.tif')
# extract the number of optical sections
zStack = image.shape[0] 
print(image.shape)

processedSlices = []
# iterate through each optical section
for i in range(zStack):
    current = image[i,:,:]
    normalized = exposure.rescale_intensity(current,in_range='image')
#    denoised = denoise_tv_chambolle(normalized,weight=0.1) 
#    denoisedReduced = img_as_ubyte(denoised)
    denoisedReduced = img_as_ubyte(normalized)
    processedSlices.append(denoisedReduced)

final = np.stack(processedSlices, axis=0)
tifffile.imwrite('./test.tif',final)
'''
    plt.figure(figsize=(10,10))
    plt.imshow(denoisedReduced, cmap='viridis')
    plt.axis('off')
    plt.show()
'''

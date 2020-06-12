import Images
import TestImages
import ImageMetadata
import ImageAxes
import ImageDraw
import ImageView
import ImageTransformations
import ImageFiltering


image2Filter = TestImages.testimage("lighthouse")
#add noise to image
noiseAddition = Images.channelview(image2Filter)
noiseAddition = eltype(noiseAddition).(clamp.(noiseAddition.+ randn.() .* 0.1, 0, 1))
noisyImage = Images.colorview(Images.RGB, noiseAddition)

#ImageView.imshow(noisyImage)
sigma = 0.8
gauss = ImageFiltering.KernelFactors.gaussian(sigma)
gaussKernel = kernelfactors((gauss, gauss))

bilateralFunction = 
filteredImage = ImageFiltering.MapWindow.mapwindow()
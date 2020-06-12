import Images
import TestImages
import ImageMetadata
import ImageAxes
import ImageDraw
import ImageView
import ImageTransformations
import ImageFiltering

ImageFromTestImages = TestImages.testimage("lighthouse")
ImageView.imshow(ImageFromTestImages)

ImageFromTestImagesGray = Images.Gray.(ImageFromTestImages)

shrinkedImage = Images.imresize(ImageFromTestImages, ratio = 0.5)
ImageView.imshow(shrinkedImage)

newSize = div.(size(ImageFromTestImages), 2)
blurValue = 0.1
sigma = map((o,n)->blurValue*o/n, size(ImageFromTestImages), newSize)
gaussFilter = ImageFiltering.KernelFactors.gaussian(sigma)
filtAndResizedImage = Images.imresize(Images.imfilter(ImageFromTestImages, gaussFilter, Images.NA()), newSize)
ImageView.imshow(filtAndResizedImage)
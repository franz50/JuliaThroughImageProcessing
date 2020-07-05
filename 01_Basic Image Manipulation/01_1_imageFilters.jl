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

image2Use = Images.Gray.(noisyImage)

ImageView.imshow(image2Use)
#sigma = 0.8
#gauss = ImageFiltering.KernelFactors.gaussian(sigma)
#gaussKernel = kernelfactors((gauss, gauss))

function bilateralFunction( imageWindow )
    std_spatial = 8.0
    std_pixelVal = 0.4

    normFactor_space = 1 / (2* pi * std_spatial)
    normFactor_pixelVal = 1 /(2 * pi * std_pixelVal)

    filteredValue = 0.0
    filteredNormFactor = 0.0
    centerRowIndex = ceil(Int, length(axes(imageWindow, 1)) / 2)
    centerColIndex = ceil(Int, length(axes(imageWindow, 2)) / 2)

    for rowIndex = axes(imageWindow, 1)
        for colIndex = axes(imageWindow, 2)
            spatialDistance = abs2(rowIndex - centerRowIndex ) + abs2(colIndex - centerColIndex)
            pixelDistance   = abs(imageWindow[rowIndex, colIndex] - imageWindow[centerRowIndex,centerColIndex] )

            gauss_spatial   = normFactor_space * exp(spatialDistance / (2 * abs2(std_spatial)))
            gauss_pixel     = normFactor_pixelVal * exp(pixelDistance / (2 * abs2(std_pixelVal))) 

            filteredValue +=  gauss_spatial * gauss_pixel *  imageWindow[rowIndex,colIndex]
            filteredNormFactor += gauss_spatial * gauss_pixel
        end 
    end

    filteredValue = filteredValue / (filteredNormFactor)
    return filteredValue 
end

prova = [5,5]
filteredImage = ImageFiltering.MapWindow.mapwindow(bilateralFunction, image2Use,prova)

ImageView.imshow(filteredImage)
function gray=ycbcr2gray(image)
image-ycbcr2rgb(image);
gray=rgb2gray(image);
end

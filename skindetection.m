function skin= skindetection(image1)
% clear all
% video1 = videoinput('macvideo');
% preview(video1);
% pause(2);
% image1=getsnapshot(video1);
% imshow(image1,[]);
K1=image1;
loc=[K1(:,:,3)>=135 & K1(:,:,3) <=160 & K1(:,:,2)>=105 & K1(:,:,2)<=135 & K1(:,:,1)<160 & K1(:,:,1)>91];
gray=ycbcr2gray(K1);
se = strel('square',4);
dilatedI = imdilate(loc,se);
fillhole = imfill(dilatedI,'holes');
out=logical(bwlargestblob(fillhole,4));
skin = zeros(size(gray));
skin(out)=gray(out);
end


function [outim] = bwlargestblob(im,connectivity)
[imlabel totalLabels] = bwlabel(im,connectivity);
sizeBlob = zeros(1,totalLabels);
for i=1:totalLabels,
    sizeblob(i) = length(find(imlabel==i));
end
[maxno largestBlobNo] = max(sizeblob);

outim = zeros(size(im),'uint8');
outim(find(imlabel==largestBlobNo)) = 1;
end

    
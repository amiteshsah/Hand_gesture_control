% hand detection in a video
clear all,close all,clc;
video1 = videoinput('macvideo');
preview(video1);
pause(1);
figure(2);
set(gcf, 'BackingStore', 'off'); 
while 1
I1=getsnapshot(video1);
hand1=skindetection(I1);
set(0,'CurrentFigure',2)
imshow(hand1,[]);
end
closepreview(video1);
clc;clear all;close all

mean_ui=zeros(1,1);
mean_vi=zeros(1,1);
xaxis=zeros(1,1);
result=cell(100,1);
%% Reading a video
video1 = videoinput('macvideo');
% Create an image object for previewing.
vidRes = get(video1, 'VideoResolution'); 
nBands = get(video1, 'NumberOfBands'); 
hImage = image( zeros(vidRes(2), vidRes(1), nBands) ); 
preview(video1, hImage); 

%preview(video1);
pause(2);
frame=1;

figure(2);
    set(gcf,'Position',[650 650 600 800],'BackingStore', 'off'); 
figure(3);
    set(gcf,'Position',[1 1 600 300],'BackingStore', 'off'); 
figure(4);
    set(gcf,'Position',[650 1 600 300],'BackingStore', 'off'); 
  

% x=[0 1 1 0 0 0 1 1 0 0 NaN 1 1 NaN 1 1 NaN 0 0];
% y=[0 0 1 1 0 0 0 1 1 0 NaN 0 0 NaN 1 1 NaN 1 1];
% z=[0 0 0 0 0 1 1 1 1 1 NaN 1 0 NaN 0 1 NaN 1 0];
% rotation_axis=[1 0 0];
%cube_h=plot3(x-0.5,y-0.5,z-0.5);

rotation_origin=[0 0 0];
xx=[0 0 1 1 0 NaN 0 1 NaN 1 0;...
    0 0 1 1 0 NaN 0 1 NaN 1 0];
yy=[0 1 1 0 0 NaN 1 1 NaN 1 1;...
    0 1 1 0 0 NaN 0 0 NaN 0 0];
zz=[1 1 1 1 1 NaN 1 1 NaN 0 0;...
    0 0 0 0 0 NaN 1 1 NaN 0 0];
cube_h=surf([xx]-0.5,[yy]-0.5,[zz]-0.5);
axis('square');
axis([-1 1 -1 1 -1 1]*2);
%grid on
%view(-37.5,15);
view(10,10);
%set(cube_h,'erasemode','background');
fig_h=gcf;
%%
while 1
    tic
    K=getsnapshot(video1);
    hand1=skindetection(K);
    K3=imresize(hand1,0.5,'nearest');
    images(:,:,1)=K3;
    if (size(images,3) >= 2)
    set(0,'CurrentFigure',2)
    imshow(images(:,:,1));
       [U,V] = optical_flow1(images);
       [x, y] = meshgrid(1:5:size(U,1), size(U,1):-5:1); 
            qu = U(1:5:size(U,1), 1:5:size(U,1));
            qv = V(1:5:size(U,1), 1:5:size(U,1));
              Ui = interp2(U,x,y);
              Vi = interp2(V,x,y); 

         hold on;            
            quiver(x,y,Ui,Vi,2,'r');                              
         hold off;
            drawnow;
            
            sum_ui=sum(sum(Ui));
            sum_vi=sum(sum(Vi));
            
            mean_ui(1,frame)=sum_ui;
            mean_vi(1,frame)=sum_vi;
     
        [rotation_axis,rotation_increment,direction,teta]=rotation2(sum_ui,sum_vi);
        result{frame+1}={sum_ui,sum_vi,teta,direction};
        rotate(cube_h,rotation_axis,...
            rotation_increment*1000,rotation_origin);
        drawnow;
           
        set(0,'CurrentFigure',3) 
           plot(xaxis,mean_ui,xaxis,mean_vi);
           %plot(mean_ui,mean_vi);
           legend('mean Ux','mean Vy');
           title('Mean');xlabel('Time');ylabel('Magnitude mean Ux and Vy');
            drawnow;
        
    end

    images(:,:,2) = K3;    
    frame=frame + 1;
    xaxis(1,end+1)=frame;
    mean_ui(1,end+1)=mean_ui(1,end);
    mean_vi(1,end+1)=mean_vi(1,end);
sum_ui=0;
sum_vi=0;
clear direction
    toc
  end
 if exist('video1')
  delete(video1);
  clear video1;    
 end 
 

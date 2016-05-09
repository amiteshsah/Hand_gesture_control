% Rotation from mean values
load xm
load ym
x=[0 1 1 0 0 0 1 1 0 0 NaN 1 1 NaN 1 1 NaN 0 0];
y=[0 0 1 1 0 0 0 1 1 0 NaN 0 0 NaN 1 1 NaN 1 1];
z=[0 0 0 0 0 1 1 1 1 1 NaN 1 0 NaN 0 1 NaN 1 0];

rotation_origin=[0 0 0];
rotation_axis=[1 0 0];
cube_h=plot3(x-0.5,y-0.5,z-0.5);
axis('square');
axis([-1 1 -1 1 -1 1]*2);
grid on
%view(-37.5,15);
set(cube_h,'erasemode','background');
fig_h=gcf;

for i=1:length(xm)
    m=sqrt(xm(1,i)^2+ym(1,i)^2);
    rotation_increment=m;
     teta = mod(atan2(ym(1,i),xm(1,i)),2*pi)*180/pi;
    if  (teta>315 && teta<45) || (teta>135 && teta<225)
        rotation_axis=[0 1 0];    
    else if (teta<135 && teta>45) || (teta<315 && teta>225)
        rotation_axis=[1 0 0];    
        end
    end
        rotate(cube_h,rotation_axis,...
            rotation_increment,rotation_origin);
        drawnow;
        
end

%%
load xm
load ym
xx=[0 0 1 1 0 NaN 0 1 NaN 1 0;...
    0 0 1 1 0 NaN 0 1 NaN 1 0];
yy=[0 1 1 0 0 NaN 1 1 NaN 1 1;...
    0 1 1 0 0 NaN 0 0 NaN 0 0];
zz=[1 1 1 1 1 NaN 1 1 NaN 0 0;...
    0 0 0 0 0 NaN 1 1 NaN 0 0];

rotation_origin=[0 0 0];
rotation_axis=[1 0 0];
cube_h=surf([xx],[yy],[zz]);
axis('square');
axis([-1 1 -1 1 -1 1]*2);
grid on
%view(-37.5,15);
set(cube_h,'erasemode','background','facecolor','g');
fig_h=gcf;

for i=1:length(xm)
    m=sqrt(xm(1,i)^2+ym(1,i)^2);
    rotation_increment=m;
     teta = mod(atan2(ym(1,i),xm(1,i)),2*pi)*180/pi;
    if  (teta>315 && teta<45) || (teta>135 && teta<225)
        rotation_axis=[0 1 0];    
    else if (teta<135 && teta>45) || (teta<315 && teta>225)
        rotation_axis=[1 0 0];    
        end
    end
        rotate(cube_h,rotation_axis,...
            rotation_increment,rotation_origin);
        drawnow;
        
end

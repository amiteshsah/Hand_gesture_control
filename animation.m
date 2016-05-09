%rotation 
% %% Set up 3D plot to record
% figure(171);clf;
% surf(peaks,'EdgeColor','none','FaceColor','interp','FaceLighting','phong')
% daspect([1,1,.3]);axis tight;
% 
% %% Set up recording parameters (optional), and record
% %OptionZ.FrameRate=15;OptionZ.Duration=5.5;OptionZ.Periodic=true;
% %CaptureFigVid([-20,10;-110,10;-190,80;-290,10;-380,10], 'WellMadeVid',OptionZ)
%%
 A = [0 0 0];
 B = [1 0 0];
 C = [0 1 0];
 D = [0 0 1];
 E = [0 1 1];
 F = [1 0 1];
 G = [1 1 0];
 H = [1 1 1];
 P = [A;B;F;H;G;C;A;D;E;H;F;D;E;C;G;B];

 roll = -0.3064; pitch = -1.2258; yaw = 9.8066;
dcm = angle2dcm(yaw, pitch, roll);
P = P*dcm;
plot3(P(:,1),P(:,2),P(:,3)) % rotated cube

%%
vertex_matrix = [0 0 0
1 0 0
1 1 0
0 1 0
0 0 1
1 0 1
1 1 1
0 1 1];
faces_matrix = [1 2 6 5
2 3 7 6
3 4 8 7
4 1 5 8
1 2 3 4
5 6 7 8];
patch('Vertices',vertex_matrix,'Faces',faces_matrix,...
'FaceVertexCData',hsv(8),'FaceColor','interp')
view(3); axis square
%%
translation_matrix = repmat([1 0 0],size(vertex_matrix,1),1);
vertex_matrix = vertex_matrix + translation_matrix;
patch('Vertices',vertex_matrix,'Faces',faces_matrix,...
'FaceVertexCData',hsv(8),'FaceColor','interp')
view(3); axis square
%%
%The line trace animation
t=0:0.01:10*pi;
x=t.*sin(t);
y=t.*cos(t);
comet3(x,y,t);

%%
% By using drawnow
t=0:0.01:10*pi;
x=t.*sin(t);
y=t.*cos(t);
comet3(x,y,t);
axislimits=[min(x) max(x) min(y) max(y) min(t) max(t)];
figure,
for indexnumber=1:length(x)
    plot3(x(indexnumber),y(indexnumber),...
        t(indexnumber),'bo');
    axis(axislimits);
    drawnow;
end
%%
%using line command
t=0:0.01:10*pi;
x=t.*sin(t);
y=t.*cos(t);
comet3(x,y,t);
axislimits=[min(x) max(x) min(y) max(y) min(t) max(t)];
figure,
axis(axislimits);
line_handle=line(x(1),y(1),t(1),...
    'color','c');
for indexnumber=2:length(x)
    delete(line_handle);
    line_handle=line(x(indexnumber),...
                     y(indexnumber),...
                     t(indexnumber),...
                     'color','b');
     drawnow;
end
%% 
%Erase Mode
t=0:0.01:10*pi;
x=t.*sin(t);
y=t.*cos(t);
comet3(x,y,t);
axislimits=[min(x) max(x) min(y) max(y) min(t) max(t)];
figure,
line_handle=line(x(1),y(1),t(1),...
    'color','c');
set(line_handle,'erasemod','xor');
axis(axislimits);
for indexnumber=2:length(x)
    set(line_handle,'xdata',x(indexnumber),...
                     'ydata',y(indexnumber),...
                     'zdata',t(indexnumber));
     drawnow;
end

%%
%Animating series of coordiantes (lines)
x=0:(pi/48):pi;
ropeheight=sin(x);
line_handle=plot(x,ropeheight);
axis([0 pi -1.1 1.1]);
grid on;
set(line_handle,'Linewidth',3,'EraseMode','background');
for phi=0:pi/64:10*pi
    set(line_handle,'ydata',cos(phi)*ropeheight);
    drawnow;
end

%% 
% 3D spinning wire frame cube
x=[0 1 1 0 0 0 1 1 0 0 NaN 1 1 NaN 1 1 NaN 0 0];
y=[0 0 1 1 0 0 0 1 1 0 NaN 0 0 NaN 1 1 NaN 1 1];
z=[0 0 0 0 0 1 1 1 1 1 NaN 1 0 NaN 0 1 NaN 1 0];

cube_h=plot3(x-0.5,y-0.5,z-0.5);
axis('square');
axis([-1 1 -1 1 -1 1]*2);
view(-37.5,15);
set(cube_h,'erasemode','background');
rotation_increment=5; %degrees
rotation_axis=[0 0 1];
rotation_origin=[0 0 0];
num_of_incr=360/rotation_increment;
for loop=1:num_of_incr
    rotate(cube_h,rotation_axis,...
        rotation_increment,rotation_origin);
    drawnow;
end

%%
% truly interactive animation 
x=[0 1 1 0 0 0 1 1 0 0 NaN 1 1 NaN 1 1 NaN 0 0];
y=[0 0 1 1 0 0 0 1 1 0 NaN 0 0 NaN 1 1 NaN 1 1];
z=[0 0 0 0 0 1 1 1 1 1 NaN 1 0 NaN 0 1 NaN 1 0];

rot_axis=[0 01];
rot_origin=[0 0 0];

cube_h=plot3(x-0.5,y-0.5,z-0.5);
axis('square');
axis([-1 1 -1 1 -1 1]*2);
view(-37.5,15);

set(cube_h,'erasemode','background');
rotation_increment=5; %degrees
rotation_axis=rot_axis;
rotation_origin=rot_origin;

fig_h=gcf;
key=28;

while key~=27 % Watch for esc key
    if waitforbuttonpress==1
        key=get(fig_h,'currentcharacter');
        
        switch key
            case 28  % <- rotate left
                rotation_axis=[0 0 1];
                rotation_increment=-5;
            case 29  % -> rotate right
                rotation_axis=[0 0 1];
                rotation_increment=5; 
            case 30  % A rotate up
                rotation_axis=[0 1 0];
                rotation_increment=5;
            case 31  % v rotate down
                rotation_axis=[0 1 0];
                rotation_increment=-5;
            case 27 % Esc Key
                close(fig_h)
                clear 
                return
        end
        
        rotate(cube_h,rotation_axis,...
            rotation_increment,rotation_origin);
        drawnow;
    end
end

x=key;

%%
%cube with surface object
%Generate vertices for the surface of single cube
xx=[0 0 1 1 0 NaN 0 1 NaN 1 0;...
    0 0 1 1 0 NaN 0 1 NaN 1 0];
yy=[0 1 1 0 0 NaN 1 1 NaN 1 1;...
    0 1 1 0 0 NaN 0 0 NaN 0 0];
zz=[1 1 1 1 1 NaN 1 1 NaN 0 0;...
    0 0 0 0 0 NaN 1 1 NaN 0 0];
% Set up rotataion vaibales
rotation_increment=5; %degrees
rotation_axis=[0 0 1];
rotation_origin=[0 0 0];
num_of_incr=360/rotation_increment;
%Generate 3 translated version of the cube
s1_h=surf([xx]-.5,[yy]-.5,[zz]-.5);
set(s1_h,'erasemode','background','facecolor','g');
s2_h=surface([xx]+1.5,[yy]+1.5,[zz]+1.5);
set(s2_h,'erasemode','background','facecolor','r');
s3_h=surface([xx]+1.5,[yy],[zz]-.5);
set(s3_h,'erasemode','background','facecolor','b');

%Set up the proper proportion
axis([-3 3 -3 3 -3 3]);axis('square');
% Define the rotation specification for each cube
for loop=1:num_of_incr
      rotate(s1_h,rotation_axis,...
            rotation_increment,rotation_origin);
      rotate(s2_h,rotation_axis+[1 1 0],...
            rotation_increment,rotation_origin);
      rotate(s3_h,rotation_axis,...
            rotation_increment,rotation_origin);
      drawnow;
end



                



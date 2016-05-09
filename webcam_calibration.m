 clc; clear all; close all
 [PX,PY,PZ]=textread('world coordinate.txt','', 'delimiter', ',');
 [px,py]=textread('image_coordinate.txt','', 'delimiter', ',');
 % Input pixel coordinates by mouse
load img_checker.mat
%  %Checkerboard=imread('checkerboard.jpg');
 img_checker=ycbcr2rgb(img_checker);
%  img_checkergray=rgb2gray(img_checker);
%   figure,imshow(img_checkergray);
% [r,c]=size(img_checkergray);
% [px,py] = ginput(30);
%  A1=[px,py];
% dlmwrite('image_coordinate.txt',A1,'precision',8)

% Plotting 3D fiducial points and corresponding image points
figure,
subplot(1,2,1),scatter3(PX,PY,PZ) %origin 
title('World Coordinates');
axis equal;   %# Make the axes scales match
hold on;      %# Add to the plot
xlabel('x');ylabel('y');zlabel('z');

subplot(1,2,2),imshow(img_checker), hold on, scatter(px,py)
xlabel('x');ylabel('y');
title('Image Coordinates');

% Define the world points in one matrix
l=length(PX);
one=ones(l,1);
Pi=[PX PY PZ one];

% Create a  P matrix
j=1;
zero=zeros(1,4);
for i=1:30
    P(j,:)=[Pi(i,:) zero -px(i).*Pi(i,:)];
    P(j+1,:)=[zero Pi(i,:) -py(i).*Pi(i,:)];
    j=j+2;
end


% Solve 'm' to minimise (Q*m)^2

% Perform SVD of P
[U,S,V]=svd(P);
[min_val,min_index]=min(diag(S(1:12,1:12)));

% m is given by right singular vector of min. singular value
m=V(1:12,min_index);

% Projection matrix reshaping
M=[m(1:4,1)';m(5:8,1)';m(9:12)']

%%
% 2)Estimation of Intrinsic and Extrinsic Parameter

A=M(1:3,1:3);
b=M(1:3,4);

a1=A(1,:);
a2=A(2,:);
a3=A(3,:);

rho=1/norm(a3);
r3=rho*a3;
x0=(rho^2)*dot(a1,a3);
y0=(rho^2)*dot(a2,a3);

cos_teta=-(dot(cross(a1,a3),cross(a2,a3)))/((norm(cross(a1,a3)))*(norm(cross(a2,a3))));
sine_teta=sqrt(1-cos_teta^2);
alpha=(rho^2)*norm(cross(a1,a3))*sine_teta;
beta=(rho^2)*norm(cross(a2,a3))*sine_teta;

r1=cross(a2,a3)/norm(cross(a2,a3));
r2=cross(r3,r1);

teta=acosd(cos_teta);
cot_teta=cos_teta/sine_teta;
kappa=[alpha,-alpha*cot_teta,x0;0,beta/sine_teta,y0;0,0,1];
R=[r1;r2;r3]
kappa_inverse=inv(kappa);
t=(rho*kappa_inverse*b)'

% Creating a table for intrinsic paramenter
Intr_par={'alpha';'beta';'teta';'x0';'y0'};
value=[alpha;beta;teta;x0;y0];
Intrinsic_Parameter=table(value,'RowNames',Intr_par)


%%
% Calculate the world coordinates from the image coordinates
cal_image_co(:,i)=M*(W(i,:))';
cal_ix(i,:)=cal_image_co(1,i)/cal_image_co(3,i);
cal_iy(i,:)=cal_image_co(2,i)/cal_image_co(3,i);


 function [u,v]=optical_flow1(images)
  % //initialization of Ex Ey and Et  
  [h,w,frames]=size(images);
  Ex = zeros(h,w);  
  Ey = zeros(h,w);  
  Et = zeros(h,w);
Ex = conv2(images(:,:,1),0.25* [-1 1; -1 1],'same') + conv2(images(:,:,2), 0.25*[-1 1; -1 1],'same');
Ey= conv2(images(:,:,1), 0.25*[-1 -1; 1 1], 'same') + conv2(images(:,:,2), 0.25*[-1 -1; 1 1], 'same');
Et= conv2(images(:,:,1), 0.25*ones(2),'same') + conv2(images(:,:,2), -0.25*ones(2),'same');

% Averaging kernel
kernel=[1/12 1/6 1/12;...
           1/6 0 1/6;...
          1/12 1/6 1/12];
u=zeros(size(images(:,:,1)));
v=zeros(size(images(:,:,1)));
alpha=100;
% Iterations
for i=1:30
    % Compute local averages of the flow vectors
    uAvg=conv2(u,kernel,'same');
    vAvg=conv2(v,kernel,'same');
    % Compute flow vectors constrained by its local average and the optical flow constraints
    u= uAvg-(Ex.*((Ex.*uAvg)+(Ey.*vAvg)+Et))./(alpha^2+Ex.^2+Ey.^2); 
    v= vAvg-(Ey.*((Ex.*uAvg)+(Ey.*vAvg)+Et))./(alpha^2+Ex.^2+Ey.^2);
end
% u(isnan(u))=0;
% v(isnan(v))=0;
 end
 
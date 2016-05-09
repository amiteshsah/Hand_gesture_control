function [U,V]=optical_flow(images)

alpha=100;
iterations=3;
[h,w,frames]=size(images); 
% Implementation based on Horn's optical flow algorithm. 
%//initialzation of u and v  
U=zeros(h,w);  
V=zeros(h,w); 
  
for k = 1:frames-1  
  % //initialization of Ex Ey and Et  
  Ex = zeros(h-1,w-1,frames-1);  
  Ey = zeros(h-1,w-1,frames-1);  
  Et = zeros(h-1,w-1,frames-1);  

  %//calculating Ex Ey and Et in frame k.  
  for x = 2:w-1  
    for y = 2:h-1  
      Ex(y,x,k) = (images(y+1,x+1,k)-images(y+1,x,k)+images(y,x+1,k)...  
        -images(y,x,k)+images(y+1,x+1,k+1)-images(y+1,x,k+1)...  
        +images(y,x+1,k+1)-images(y,x,k+1))/4;  

      Ey(y,x,k) = (images(y,x,k)-images(y+1,x,k)+images(y,x+1,k)...  
        -images(y+1,x+1,k)+images(y,x,k+1)-images(y+1,x,k+1)...  
        +images(y,x+1,k+1)-images(y+1,x+1,k+1))/4;  

      Et(y,x,k) = (images(y+1,x,k+1)-images(y+1,x,k)+images(y,x,k+1)...  
        -images(y,x,k)+images(y+1,x+1,k+1)-images(y+1,x+1,k)...  
        +images(y,x+1,k+1)-images(y,x+1,k))/4;  
    end  
  end 
  
 
% for N number of iterations, updated u and v value
  for nn = 1:iterations  
    for x = 2:w-1  
      for y = 2:h-1  
        U_bar = (U(y-1,x)+U(y,x+1)+U(y+1,x)+U(y,x-1))/6+...  
          (U(y-1,x-1)+U(y-1,x+1)+U(y+1,x+1)+U(y+1,x-1))/12;  

        V_bar = (V(y-1,x)+V(y,x+1)+V(y+1,x)+V(y,x-1))/6+...  
          (V(y-1,x-1)+V(y-1,x+1)+V(y+1,x+1)+V(y+1,x-1))/12;   
        temp = (Ex(y,x,k)*U_bar+Ey(y,x,k)*V_bar+Et(y,x,k))/(alpha^2 + Ex(y,x,k)^2 + Ey(y,x,k)^2);   
        U(y,x) = U_bar-Ex(y,x,k)*temp;  
        V(y,x) = V_bar-Ey(y,x,k)*temp;  
      end  
    end  
  end  
   
end  
  
function [rotation_axis,rotation_increment]=rotation1(mean_ui,mean_vi)
xm=mean_ui;
ym=mean_vi;
    m=sqrt(xm^2+ym^2);
    rotation_increment=m;
     teta = mod(atan2(ym,xm),2*pi)*180/pi;
    if  (teta>=315 && teta<=45) || (teta>=135 && teta<=225)
        rotation_axis=[0 1 0]; 
    elseif (teta<135 && teta>45) || (teta<315 && teta>225)
        rotation_axis=[1 0 0];    
    else
        rotation_axis=[1 0 0]; 
    end
        
end
   
        


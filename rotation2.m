function [rotation_axis,rotation_increment,direction,teta]=rotation2(mean_ui,mean_vi)
xm=mean_ui;
ym=mean_vi;
     teta = mod(atan2(ym,xm),2*pi)*180/pi;
     if teta>=45 && teta<=135
         key=30;
     elseif teta>135 && teta<=225
         key=28;
     elseif teta>225 && teta<=315
         key=31;
     elseif (teta>315 && teta<360) || (teta>0 && teta<45)
         key=29;
     else 
         key=32;
     end
        
        switch key
            case 28  % <- rotate left
                direction='left';
                rotation_axis=[0 0 1];
                rotation_increment=-5;
            case 29  % -> rotate right
                direction='right';
                rotation_axis=[0 0 1];
                rotation_increment=5; 
            case 30  % A rotate up
                direction='up';
                rotation_axis=[0 1 0];
                rotation_increment=5;
            case 31  % v rotate down
                direction='down';
                rotation_axis=[0 1 0];
                rotation_increment=-5;
            case 32 % Remain still
                direction='No rotation';
                rotation_axis=[0 1 0];
                rotation_increment=0;   
            case 27 % Esc Key
                close(fig_h)
                clear 
        end
end


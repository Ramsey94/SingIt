% function Auditive2(frame, fs,d)
function Auditive2(frame, fs,sosbp, gbp)%con filtro pasabandas
global f0l
global currentt
% frame=filtfilt(d,frame);
frame = frame - mean (frame);
frame = filtfilt(sosbp, gbp, frame);% Con filtro pasabandas
windowframe=2*round(0.04*fs);        
[rxx,~] = xcorr(frame, frame);

% find peaks to measure the freq
rxx(rxx < 0) = 0; %eliminar la parte negativa
center_peak_width = find(rxx(windowframe:end) == 0 ,1); %find first zero after center
    
rxx(windowframe-center_peak_width : windowframe+center_peak_width  ) = min(rxx);%Eliminar el primer pico

[~, loc] = max(rxx); % encontrar el siguiente pico y su localizacion
period = abs(loc - length(frame)+1); %el periodo en muestras
clc;
f0=fs/period;
% convert pitch into MIDI numer asociated
f0=12*log2(f0/440)+69;
f0l =[f0l f0'];
% voice =[voice frame']; 


currentt
if (f0<=currentt+0.5 && f0>= currentt-0.5)     
% cuando esta melo melito
    a=[0.3 0.3 0;0 1 0 ; 0.3 0 0];
    drawnow
    
elseif (f0>= currentt+0.5)
% cuando esta malo por arrib
    a=[1 1 0;0 0.3 0 ; 0.3 0 0];
drawnow  

else
% cuando esta malo por abajo  
    a=[0.3 0.3 0;0 0.3 0 ; 1 0 0];
drawnow
end

colormap(a);
% grid on
set(gca,'visible','off')
end
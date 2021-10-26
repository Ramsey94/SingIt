%% video player
workingDir = tempname;
mkdir(workingDir)
mkdir(workingDir,'images')

shuttleVideo = VideoReader('Mel2tempo60.m4v');

ii = 1;

while hasFrame(shuttleVideo)
   img = readFrame(shuttleVideo);
   filename = [sprintf('%03d',ii) '.jpg'];
   fullname = fullfile(workingDir,'images',filename);
   imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
   ii = ii+1;
end

imageNames = dir(fullfile(workingDir,'images','*.jpg'));
imageNames = {imageNames.name}';

outputVideo = VideoWriter(fullfile(workingDir,'shuttle_out.avi'));
outputVideo.FrameRate = shuttleVideo.FrameRate;
open(outputVideo)


for ii = 1:length(imageNames)
   img = imread(fullfile(workingDir,'images',imageNames{ii}));
   writeVideo(outputVideo,img)
end


close(outputVideo)

shuttleAvi = VideoReader(fullfile(workingDir,'shuttle_out.avi'));

ii = 1;
while hasFrame(shuttleAvi)
   mov(ii) = im2frame(readFrame(shuttleAvi));
   ii = ii+1;
end


figure 
imshow(mov(1).cdata, 'Border', 'tight')


movie(mov,1,shuttleAvi.FrameRate)%linea q debe ir dsps del sound q lleva el tempo










% %% FISHER IRIS
% clear all 
% close all
% clc
% load fisheriris
% 
% %%  
% Z=linkage(meas,'average','chebychev');
% T=cluster(Z,'maxclust',3);%le puedo decir el numm de grupos q yo necesito
% % usar  'inconsistent' para definir un umbral donde no se sabe cuantos
% % clusters hay
% 
% 
% % dendrograma es la representacion grafica de la gerarquia de los datos
% cutoff=mean([Z(end-2,3),Z(end-1,3)]);
% dendogram(Z,'ColorThreshold',cutoff);
% 
% 
% 
% crosstab(T,species)%clumnas son la categoria real, lo q diria specias y las filas 
% % 
% 
% 
% 
% 
% 
% %% EJERCICIO EN CLASE
% 
% rng default
% v_xgrn=-4+8*rand(1,200);
% v_xred=-4+8*rand(1,200);
% 
% v_ygrn=1+sin(v_xgrn)+0.5*rand(1,200);
% v_yred=-1+sin(v_xred)+0.5*rand(1,200);
% 
% m_X=[v_xred,v_yred;v_xgrn,v_ygrn];
% 
% figure;
% plot(v_xgrn,v_ygrn,'go')
% hold on
% plot(v_xred,v_yred,'ro')
% hold off
% 
% %final: dendograma y crostap q muestre la separacion de muestras
% Z=linkage(m_X);
% T=cluster(Z,'maxcluster',2);
% cutoff=mean([Z(end-2,3),Z(end-1,3)]);
% dendogram(Z,'ColorThreshold',cutoff);
% crosstab(T,species)
% 
% 
% 
% 
% % tarea mirar k means y silouete
% 

% 
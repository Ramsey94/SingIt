function varargout = results(varargin)
% RESULTS MATLAB code for results.fig
%      RESULTS, by itself, creates a new RESULTS or raises the existing
%      singleton*.
%
%      H = RESULTS returns the handle to a new RESULTS or the handle to
%      the existing singleton*.
%
%      RESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULTS.M with the given input arguments.
%
%      RESULTS('Property','Value',...) creates a new RESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before results_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to results_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help results

% Last Modified by GUIDE v2.5 19-Apr-2020 22:25:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @results_OpeningFcn, ...
                   'gui_OutputFcn',  @results_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before results is made visible.
function results_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to results (see VARARGIN)
ah=axes('unit','normalized','position',[0 0 1 1]);
bg=imread('RESULTS.jpg');imagesc(bg);
set(ah,'handlevisibility','off','visible','off')


% Choose default command line output for results
try
hf=findobj('Name','main_menu');
close(hf)
catch
end
try
hf=findobj('Name','VoiceMonitor');
close(hf)
catch
end

handles.output = hObject;
% datos=varargin{1}; %INFORMACION MIDI
% handles.datos=datos;
MIDIDATA=varargin{1};
try
PACK=varargin{2};
catch
end

% <<<<<<<<<<<<<<<<<<<<<<<<<<<< Debug bar starts here>>>>>>>>>>>>>>>>>>>>> %
% *********************************************************************** %

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%crear una se;al mas grande%%%%%%%%%%%%%%%%%%%
Notes = midiInfo(MIDIDATA.midi,0);
NewNotes=MIDIDATA.NoteTimes; %remplazar aqui por el valor notes que recibo desde tool/
Notes(:,3)=NewNotes(:,1); 
Notes(:,5:6)=NewNotes(:,2:3);%buscar la columna de la duracion de las notas
[PR,t,nn] = piano_roll(Notes); %PR is a matrix that contains the info about
                               % notes in time
% Notes_matrix=PR;
% crear señal de tonos %%
%clecrear el vector vacio que contendra la señal 
NoteSignal=[];
Col=length(PR);
Row=length(nn);
%for que recorre las columnas
for i=1:Col
    %for que recorre las filas
    for j=1:Row
        if PR(j,i)==1
            NoteSignal(1,i)=nn(j);
        end  
    end
end

indices = find(abs(NoteSignal(1,:))==0);
NoteSignal(1,indices) = NaN;
%NoteSIgnal y t son el conjunto de notas midi y su distribucion en el
%tiempo, ademas 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%% Contar el numero de notas seguidas %%%%%%%%%%%%%%%%%%%% %
d = [true, diff(NoteSignal) ~= 0, true];  % TRUE if values change
n = diff(find(d));               % Number of repetitions
Y = repelem(n, n);

f0l=datos.f0l;
    
pitch = interp1(linspace(0,1,length(f0l)),f0l,linspace(0,1,length(NoteSignal))); % interpolar se;al objetivo y se;al medida

indices = find(abs(NoteSignal(1,:))==0);
try
NoteSignal(1,indices) = NoteSignal(1,indices-1);%eliminar los ceros de la 
catch
    NoteSignal(1,indices) = NoteSignal(1,indices+1);
end

% se;al objetivo

                                                 
                                                 
                                            
indices = find(abs(pitch(1,:))>max(NoteSignal));

pitch(1,indices) = NoteSignal(1,indices); %regalarle un poco de nota si no

% for m=1:length(indices)
% try
%     loc=indices(m);
%     aprox1=mean(pitch(1,[loc-6:loc]));
%     error1=NoteSignal(m)-aprox1;
% catch
% end
% try
%     loc=indices(m);
%     aprox2=mean(pitch(1,[loc:loc+6]));
%     error2=NoteSignal(m)-aprox2;
% catch
% end
% 
% % cual esta mas cerca del valor real?
% 
% 
% % cual error es mas cercano a cero?
% try
% if abs(error1)<abs(error2)
% pitch(1,m)=aprox1;
% end
% catch
% end
% try
% if abs(error2)<abs(error1)
% pitch(1,m)=aprox2;
% end
% catch
% end
% end






indices = find(abs(pitch(1,:))<min(NoteSignal));
try
pitch(1,indices) = pitch(1,indices+1);%regalarle un poco de nota si no % hace nada
catch
end
try
pitch(1,indices) = pitch(1,indices-1);%regalarle un poco de nota si no 
catch
end



% WARNING: if no singing, the system will put correct almost all notes
% creating a very fake results because of lines 113 to 118
% pitch(1,indices) = NaN;

% pitch = circshift(pitch,-3);%activar si hay que corregir delay manualmente






% %%%%%%%%%%%%%%%%%%%%%%%%%%% Tempo features %%%%%%%%%%%%%%%%%%%%%%%%%%%% %

j=1;
metrica=MIDIDATA.NoteTimes();
for i=1:length(metrica)
    Notaactual=metrica(i,1);%componentes para analizar datos nota a nota
    t0=metrica(i,2);        %componentes para analizar datos nota a nota
    tf=metrica(i,3);        %componentes para analizar datos nota a nota
%     i corresponde al numero de la nota actual
    
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %              
tseg=round(t*100); % t ms-> seg
t0=round(t0*100);       
tf=round(tf*100);
% find index position of t0 and tf in the tseg vector 
indice0(i) = find(tseg(1,:)== t0);
indicef(i) = find(tseg(1,:)== tf);
%extraemos la porcion de la senal que corresponde a esa ventana para
%hacer comparacion tiempo frecuencia nota a nota
segment=pitch(indice0(i):indicef(i));
reference=NoteSignal(indice0(i):indicef(i));
% Plot note analizis >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% plot(t(indice0:indicef),segment);
% hold on
% plot(t(indice0:indicef),reference);
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
error=reference-segment; %el error entre voz y MIDI

% Ahora se debe exrtaer la mayor info posible de ambos segmentos...

% componente ritmica: Se busca el primer cruce por cero en el error>>>>>>>>
zerocross = find( error(1,:)>=-0.5 & error(1,:)<=0.5);
TF = isempty(zerocross);
if TF==1;
    accuracy(i)=3;
    Tataque(i)=-1;% en muestras (MAL triangulo amarillo punta hacia la izq)
else
    rango=length(error)/3;
if zerocross(1) <= rango
    accuracy(i)=1; %mejor nota CIRCULO VERDE
    Tataque(i)=0;% en muestras
elseif (zerocross(1) >= rango  & zerocross(1) <= 2*rango )
    accuracy(i)=2;%Aceptable 
    Tataque(i)=1;% TRIANGULO AMARIILO APUNTANDO A LA DERECHA
else
    accuracy(i)=3;%mal
    Tataque(i)=-1;% ROJO
end

end
%  componente melodica: se busca que el error no supere 1 semitono (vibrato)
% inrange = find( error(1,:)>=-0.3 & error(1,:)<=0.3);
inrange = find( abs(error(1,:))<=0.5); %UMBRAL CALIFICACION MELODICA ADD BUTTTON
IR = isempty(inrange);
if IR==1
    accuracymel(i)=3;% wors note
elseif length(inrange)>=((3*length(error))/4)
    accuracymel(i)=1;% best note
else
    accuracymel(i)=2;% regular note
end

Npositiv=length(find(error(1,:)>0));
Nnegativ=length(find(error(1,:)<0));
if Npositiv > Nnegativ
    signo(i)=1;
else
    signo(i)=-1;
end   
end   




notaritmica=find(accuracy(1,:)==1);
ritstrike=length(notaritmica);
notaritmica=length(notaritmica)/length(metrica);
notaritmica=notaritmica*5;
notamelodica=find(accuracymel(1,:)==1);
melstrike=length(notamelodica);
notamelodica=length(notamelodica)/length(metrica);
notamelodica=notamelodica*5;
totalnotas=length(metrica);

% % % %  DEFINIR SI LA NOTA ESTA ALTA O BAJA % % % %






% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% agarrar las notas que tienen calificacion 1 y colorearlas de verde en una
% ventana que hablara de la componente ritmica(notas mejor puntuadas)
%colorear en naranja las que se pueden mejorar 
% colorear de rojo en las que hubo alguna dificultad significativa





% VECTORES RITMICOS
indicesGreen = find( accuracy(1,:) == 1 );
indicesOrange = find( accuracy(1,:) == 2 );
indicesRed = find( accuracy(1,:) == 3 );
% vectores con marcas de tiempo para las puntuaciones buenas, regulares y malas.
for i=1:length(indicesGreen)
    green(i)=indicef(indicesGreen(i));%RITMICO
    
end
orcou=1;
orcod=1;
for i=1:length(indicesOrange)
    Orange(i)=indicef(indicesOrange(i));%RITMICO
    Orangesign(i)=Tataque(indicesOrange(i));
    if Orangesign(i)==1
        OrangeatackR(orcou)=Orange(i);
        orcou=orcou+1;
    else
        OrangemelL(orcod)=Orange(i);
        orcod=orcod+1;
    end    
end
% % % % % % 
orcou=1;
orcod=1;
for i=1:length(indicesRed)
    Red(i)=indicef(indicesRed(i));%RITMICO
    Redsign(i)=Tataque(indicesRed(i));
    if Redsign(i)==1
        RedatackR(orcou)=Red(i);
        orcou=orcou+1;
    else
        RedatackL(orcod)=Red(i);
        orcod=orcod+1;
    end
end

% VECTORES MELODICOS
indicesGreenmel = find( accuracymel(1,:) == 1 );
indicesOrangemel = find( accuracymel(1,:) == 2 );
indicesRedmel = find( accuracymel(1,:) == 3 );
% vectores con marcas de tiempo para las puntuaciones buenas, regulares y malas.
for i=1:length(indicesGreenmel)
    greenmel(i)=indicef(indicesGreenmel(i));%RITMICO
end


orcou=1;
orcod=1;
for i=1:length(indicesOrangemel)%positions of regular notes
    signonaranjas(i)=signo(indicesOrangemel(i));
%     Orangemel(i)=indicef(indicesOrangemel(i));%RITMICO
    if signonaranjas(i)==1
        Orangemelup(orcou)=indicef(indicesOrangemel(i));
        orcou=orcou+1;
    else
        Orangemeldown(orcod)=indicef(indicesOrangemel(i));
        orcod=orcod+1;
    end
end


redcou=1;
redcod=1;

for i=1:length(indicesRedmel)
    signorojos(i)=signo(indicesRedmel(i));
%     Redmel(i)=indicef(indicesRedmel(i));%RITMICO
if signorojos(i)==1
        Redmelup(redcou)=indicef(indicesRedmel(i));
        redcou=redcou+1;
    else
        Redmeldown(redcod)=indicef(indicesRedmel(i));
        redcod=redcod+1;
    end
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% % 
% %%%%%%%%%%%%% COMPONENTE MELODICA!! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
axes(handles.axes1);
plot(t,pitch,'b');
hold on
plot(t,NoteSignal,'g','LineWidth',2);
yticks([38   40   41   43   45   47   48   50   52   53   55   57   59   60   62   64    65    67    69    71    72    74    76    77    79    81    83    84    86    88    89    91    93    95    96    98    100   101   103])
yticklabels({'D2','E2','F2','G2','A2','B2','C3','D3','E3','F3','G3','A3','B3','C4','D4', 'E4', 'F4' ,'G4' ,'A4', 'B4', 'C5' ,'D5' ,'E5', 'F5', 'G5', 'A5', 'B5', 'C6', 'D6', 'E6', 'F6' ,'G6' ,'A6' ,'B6' ,'C7' ,'D7' ,'E7' ,'F7' ,'G7'})
ylim([min(NoteSignal)-3 max(NoteSignal)+3]);
title({'Evaluación rítmica y melódica'},'FontSize',13,'FontWeight','bold')
xlabel({'Tiempo','(segundos)'},'FontSize',10,'FontWeight','bold');
ylabel('Nota','FontSize',10,'FontWeight','bold');
set(gca,'FontSize',15)
grid on
hold on
% 
% 
% % 
% HACE FALTA EXPORTA CON HANDLES. las variables que piden los plots de los
% pbmel y pbrit...
% % 
% 

handles.t=t;
handles.pitch=pitch;
handles.NoteSignal=NoteSignal;
% handles.Orangemel=Orangemel;
try
handles.Orange=Orange;
catch
end
try
handles.greenmel=greenmel;
catch
end
handles.green=green;
handles.notaritmica=notaritmica;
handles.ritstrike=ritstrike;
handles.melstrike=melstrike;
handles.totalnotas=totalnotas;
handles.notamelodica=notamelodica;
handles.notaritmica=notaritmica;
try
handles.Red=Red;
catch
end
try
handles.PACK=PACK;
catch
end

try
handles.Redmelup=Redmelup;
catch
end
try
    handles.Redmeldown=Redmeldown;
catch
end

try
handles.Orangemelup=Orangemelup;
catch
end
try
handles.Orangemeldown=Orangemeldown;
catch
end
try
handles.OrangeatackR=OrangeatackR;
catch
end
try
handles.OrangemelL=OrangemelL;
catch
end
try
handles.RedatackR=RedatackRl
catch
end
try
handles.RedatackL=RedatackL;
catch
end
pause(1)
guidata(hObject, handles);

% UIWAIT makes results wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = results_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_mel.
function pb_mel_Callback(hObject, eventdata, handles)
% hObject    handle to pb_mel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% <><><><>Invocar las variables que estan flotando en la matrix<><><><><><>
hold off
t=handles.t;


pitch=handles.pitch;
NoteSignal=handles.NoteSignal;
notamelodica=round(handles.notamelodica,2);
melstrike=handles.melstrike;
totalnotas=handles.totalnotas;
try
Orangemelup=handles.Orangemelup;
catch
end
try
Orangemeldown=handles.Orangemeldown;
catch
end
try
greenmel=handles.greenmel;
catch
end
try
Redmelup=handles.Redmelup;
catch
end
try
Redmeldown=handles.Redmeldown;
catch
end

ERROR=5-round((melstrike/totalnotas)*5,2);
% % if ERROR == 0
%     %% mensaje de que repita la sesion
%             for i=1:3
% string = sprintf('\n\n      (>º.º)>\n\n        Ups...      ');
% set(handles.text2,'string', string);
% pause(0.22)
% string = sprintf('\n\n      (>º.º)>\n\n        Ups...      ');
% set(handles.text2,'string', string);
% pause(0.2)
% string = sprintf('\n\n      (>*.*)>\n\n        Ups...      ');
% set(handles.text2,'string', string);
% pause(0.1)
% string = sprintf('\n\n      (>º.º)>\n\n        Ups...      ');
% set(handles.text2,'string', string);
% pause(0.2)
% end
%         for i=1:6
% string = sprintf('\n\n     <( ~.~)>\n\n Algo ha salido mal');
% set(handles.text2,'string', string);
% pause(0.1)
% string = sprintf('\n\n     <(~.~ )>\n\n Algo ha salido mal');
% set(handles.text2,'string', string);
% pause(0.2)
% string = sprintf('\n\n     <( ~.~)>\n\n Algo ha salido mal');
% set(handles.text2,'string', string);
% pause(0.1)
% end
% for i=1:3
% string = sprintf('           (>º.º)>\nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.22)
% string = sprintf('           (>º-º)>\nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.2)
% string = sprintf('           (>º.º)>\nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.17)
% string = sprintf('           (>º-º)>\nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.17)
% end
% 
% string = sprintf('          <(^-^ )>\nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.2)
% string = sprintf('         <(º-º<)  \nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.12)
% string = sprintf('       <(º-º<)    \nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.12)
% string = sprintf('  <(º-º<)         \nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.12)
% string = sprintf('-º<)              \nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.12)
% string = sprintf('=3  WHAMM!!       \nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.5)
% string = sprintf('                  \nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.2)
% else
axes(handles.axes1);
plot(t,pitch,'b');
hold on
plot(t,NoteSignal,'g','LineWidth',2);
yticks([38   40   41   43   45   47   48   50   52   53   55   57   59   60   62   64    65    67    69    71    72    74    76    77    79    81    83    84    86    88    89    91    93    95    96    98    100   101   103]);
yticklabels({'D2','E2','F2','G2','A2','B2','C3','D3','E3','F3','G3','A3','B3','C4','D4', 'E4', 'F4' ,'G4' ,'A4', 'B4', 'C5' ,'D5' ,'E5', 'F5', 'G5', 'A5', 'B5', 'C6', 'D6', 'E6', 'F6' ,'G6' ,'A6' ,'B6' ,'C7' ,'D7' ,'E7' ,'F7' ,'G7'});
ylim([min(NoteSignal)-3 max(NoteSignal)+3]);
title({'Evaluación rítmica y melódica'},'FontSize',15,'FontWeight','bold')
xlabel({'Tiempo','(segundos)'},'FontSize',12,'FontWeight','bold');
ylabel('Nota','FontSize',12,'FontWeight','bold');
grid on
hold on
% marcas con aciertos y errores MELODICOS
%catch and release para cada opcion
try
    plot(t(Redmeldown-15),NoteSignal(Redmeldown)+0.1,'r  ^','MarkerSize',7,'MarkerEdgeColor',[0.5,0.5,0.5],'MarkerFaceColor','r');
    hold on
catch
end
try
    plot(t(Redmelup-15),NoteSignal(Redmelup)+0.1,'r  v','MarkerSize',7,'MarkerEdgeColor',[0.5,0.5,0.5],'MarkerFaceColor','r');
    hold on
catch
end
try
        plot(t((Orangemeldown-15)),NoteSignal(Orangemeldown)+0.1,'yellow  ^','MarkerSize',7,'MarkerEdgeColor',[0.5,0.5,0.5],'MarkerFaceColor','y');
        hold on
catch
end
try
        plot(t(Orangemelup-15),NoteSignal(Orangemelup)+0.1,'yellow  v','MarkerSize',7,'MarkerEdgeColor',[0.5,0.5,0.5],'MarkerFaceColor','y');
        hold on
catch  
end
try
plot(t(greenmel-15),NoteSignal(greenmel)+0.1,'g  o','MarkerSize',7,'MarkerEdgeColor',[0.5,0.5,0.5],'MarkerFaceColor','g');
hold on
catch
end
% myString1 = sprintf('%f de 5. Acertaste a %d notas de %d',(melstrike/totalnotas)*5,melstrike,totalnotas);
myString1 = sprintf('\n\nCOMPONENTE MELÓDICA');
set(handles.text2, 'String', myString1); 
drawnow
pause(3)
myString1 = sprintf('\n\nAcertaste a %d notas de %d',melstrike,totalnotas);
set(handles.text2, 'String', myString1); 
drawnow
pause(4)
myString = sprintf('Tu puntuación aproximada es %f sobre 5.\n          <( º-º)>',round((melstrike/totalnotas)*5,2));
set(handles.text2, 'String', myString);
drawnow
pause(4)
myString = sprintf('Al final, las pruebas y calificaciones no son el único factor.\n          <("._.)>');
set(handles.text2, 'String', myString);pause(3)
drawnow
pause(3)
myString = sprintf('Lo único mejor que cantar, es cantar más.\n          <( ^U^)>');
set(handles.text2, 'String', myString);
drawnow
pause(3)
for i=1:6
    string = sprintf('\n\n    (>^-^)>\n¡I love to sing!');
set(handles.text2,'string', string);
    pause(0.25)
    string = sprintf('\n\n     (>^o^)>\n¡I love to sing!');
set(handles.text2,'string', string);
pause(0.25)
end
string = sprintf('\n\n      (>^-^)>\n  Elige una opción  ');
set(handles.text2,'string', string);
pause(0.25)
% end




% --- Executes on button press in pb_rit.
function pb_rit_Callback(hObject, eventdata, handles)
% hObject    handle to pb_rit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
OrangeatackR=handles.OrangeatackR;
catch
end
try
OrangemelL=handles.OrangemelL;
catch
end
try
RedatackL=handles.RedatackL;
catch
end
try
RedatackR=handles.RedatackR;
catch
end
hold off
t=handles.t;
pitch=handles.pitch;
notaritmica=round(handles.notaritmica,2);
NoteSignal=handles.NoteSignal;
try
Red=handles.Red;
catch
end
try
Orange=handles.Orange;
catch
end
try
green=handles.green;
catch
end
ritstrike=handles.ritstrike;
totalnotas=handles.totalnotas;




axes(handles.axes1);
plot(t,pitch,'b');
hold on
plot(t,NoteSignal,'g','LineWidth',2);
yticks([38   40   41   43   45   47   48   50   52   53   55   57   59   60   62   64    65    67    69    71    72    74    76    77    79    81    83    84    86    88    89    91    93    95    96    98    100   101   103]);
yticklabels({'D2','E2','F2','G2','A2','B2','C3','D3','E3','F3','G3','A3','B3','C4','D4', 'E4', 'F4' ,'G4' ,'A4', 'B4', 'C5' ,'D5' ,'E5', 'F5', 'G5', 'A5', 'B5', 'C6', 'D6', 'E6', 'F6' ,'G6' ,'A6' ,'B6' ,'C7' ,'D7' ,'E7' ,'F7' ,'G7'});
ylim([min(NoteSignal)-3 max(NoteSignal)+3]);
title({'Evaluación rítmica y melódica'},'FontSize',15,'FontWeight','bold')
xlabel({'Tiempo','(segundos)'},'FontSize',12,'FontWeight','bold');
ylabel('Nota','FontSize',12,'FontWeight','bold');
grid on
hold on
% marcas con aciertos y errores RITMICOS

try
plot(t(RedatackL-15),NoteSignal(RedatackL)+0.1,'r  <','MarkerSize',7,'MarkerEdgeColor',[0.5,0.5,0.5],'MarkerFaceColor','r');
catch
end
try
plot(t(RedatackR-15),NoteSignal(RedatackR)+0.1,'r  >','MarkerSize',7,'MarkerEdgeColor',[0.5,0.5,0.5],'MarkerFaceColor','r');
catch
end

try
plot(t(OrangeatackR-15),NoteSignal(OrangeatackR)+0.1,'y  >','MarkerSize',7,'MarkerEdgeColor',[0.5,0.5,0.5],'MarkerFaceColor','y');
catch
end
try
plot(t(OrangemelL-15),NoteSignal(OrangemelL)+0.1,'y  <','MarkerSize',7,'MarkerEdgeColor',[0.5,0.5,0.5],'MarkerFaceColor','y');
catch
end
ERROR=5-notaritmica;
% if ERROR == 0
%     %% mensaje de que repita la sesion
%             for i=1:3
% string = sprintf('\n\n      (>º.º)>\n\n        Ups...      ');
% set(handles.text2,'string', string);
% pause(0.22)
% string = sprintf('\n\n      (>º.º)>\n\n        Ups...      ');
% set(handles.text2,'string', string);
% pause(0.2)
% string = sprintf('\n\n      (>*.*)>\n\n        Ups...      ');
% set(handles.text2,'string', string);
% pause(0.1)
% string = sprintf('\n\n      (>º.º)>\n\n        Ups...      ');
% set(handles.text2,'string', string);
% pause(0.2)
% end
%         for i=1:6
% string = sprintf('\n\n     <( ~.~)>\n\n Algo ha salido mal');
% set(handles.text2,'string', string);
% pause(0.1)
% string = sprintf('\n\n     <(~.~ )>\n\n Algo ha salido mal');
% set(handles.text2,'string', string);
% pause(0.2)
% string = sprintf('\n\n     <( ~.~)>\n\n Algo ha salido mal');
% set(handles.text2,'string', string);
% pause(0.1)
% end
% for i=1:3
% string = sprintf('           (>º.º)>\nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.22)
% string = sprintf('           (>º-º)>\nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.2)
% string = sprintf('           (>º.º)>\nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.17)
% string = sprintf('           (>º-º)>\nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.17)
% end
% 
% string = sprintf('         <(^-^ )>\nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.2)
% string = sprintf('         <(º-º<) \nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.12)
% string = sprintf('       <(º-º<)   \nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.12)
% string = sprintf('  <(º-º<)        \nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.12)
% string = sprintf('-º<)             \nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.12)
% string = sprintf('=3  WHAMM!!      \nOprime INTENTAR DE NUEVO y prueba otra vez');
% set(handles.text2,'string', string);
% pause(0.5)
% string = sprintf('                 \nOprime INTENTAR DE NUEVO y prueba otra véz');
% set(handles.text2,'string', string);
% pause(0.2)
% else
plot(t(green-15),NoteSignal(green)+0.1,'g  o','MarkerSize',7,'MarkerEdgeColor',[0.5,0.5,0.5],'MarkerFaceColor','g');
myString1 = sprintf('\n\nCOMPONENTE RITMICA');
set(handles.text2, 'String', myString1); 
drawnow
pause(2)
myString = sprintf('\n\n Acertaste a %d notas de %d.',ritstrike,totalnotas);
set(handles.text2, 'String', myString); 
drawnow
pause(5)
myString = sprintf('Tu puntuación aproximada es %f sobre 5.\n          <( ºoº)>',notaritmica);
set(handles.text2, 'String', myString);
drawnow
pause(4)
myString = sprintf('La nota se basa muchos análisis llenos de estadísticas y números...');
set(handles.text2, 'String', myString);pause(3)
drawnow
pause(3)
myString = sprintf('Mejorar es cuestión de actitud.\n          <( ^V^)>');
set(handles.text2, 'String', myString);
drawnow
pause(3)
    for i=1:3
string = sprintf('\n\n      <( ^-^)>\n\n     ¡ANIMO!       ');
set(handles.text2,'string', string);
pause(0.22)
string = sprintf('\n\n      <(^-^ )>\n\n     ¡ANIMO!       ');
set(handles.text2,'string', string);
pause(0.2)
string = sprintf('\n\n      <( ^-^)>\n\n     ¡ANIMO!       ');
set(handles.text2,'string', string);
pause(0.17)
string = sprintf('\n\n      <(^-^ )>\n\n     ¡ANIMO!       ');
set(handles.text2,'string', string);
pause(0.2)
end
% end

 



% --- Executes on button press in pb_guardarsesion.
function pb_guardarsesion_Callback(hObject, eventdata, handles)
% hObject    handle to pb_guardarsesion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
datos=handles.datos; %INFORMACION MIDI

% ingrese el nombre del archivo
uisave('datos','sesion')


% --- Executes on button press in pb_tryagain.
function pb_tryagain_Callback(hObject, eventdata, handles)
% hObject    handle to pb_tryagain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
PACK=handles.PACK;
MIDIDATA=PACK.PACK1;
MS=PACK.PACK2;
metrica=PACK.PACK3;
VoiceMonitor(MIDIDATA,MS,metrica);
hf=findobj('Name','results');
close(hf)
catch
main_menu();
end

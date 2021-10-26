function varargout = VoiceMonitor(varargin)
% VOICEMONITOR MATLAB code for VoiceMonitor.fig
%      VOICEMONITOR, by itself, creates a new VOICEMONITOR or raises the existing
%      singleton*.
%
%      H = VOICEMONITOR returns the handle to a new VOICEMONITOR or the handle to
%      the existing singleton*.
%
%      VOICEMONITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VOICEMONITOR.M with the given input arguments.
%
%      VOICEMONITOR('Property','Value',...) creates a new VOICEMONITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VoiceMonitor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VoiceMonitor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VoiceMonitor

% Last Modified by GUIDE v2.5 19-Apr-2020 17:48:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VoiceMonitor_OpeningFcn, ...
                   'gui_OutputFcn',  @VoiceMonitor_OutputFcn, ...
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


% --- Executes just before VoiceMonitor is made visible.
function VoiceMonitor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VoiceMonitor (see VARARGIN)
%PARAMETROS INICIALES
hf=findobj('Name','main_menu');
close(hf)
% path=('C:\Users\ASUS\Dropbox\2019-2 - Danny Lasso\MATLAB\monitor_final v1.2\GUI\sonidos\piano');
% addpath(path);
% Choose default command line output for VoiceMonitor
handles.output = hObject;
MIDIDATA=varargin{1}; %INFORMACION MIDI
PACK.PACK1=varargin{1};
PACK.PACK2=varargin{2};
PACK.PACK3=varargin{3};
handles.PACK=PACK;
midicopy=MIDIDATA.midi;
MS=varargin{2};       %PARTITURA FORMATO JPG
metrica=varargin{3};
handles.metrica=metrica;
midicopy.tempo=MIDIDATA.tempo;
midicopy.tnegra=MIDIDATA.Tnegra;
handles.MIDIDATA=MIDIDATA;%PARAMETRO VISIBLE 4 EVERYONE
handles.midicopy=midicopy;
set(handles.et_bpm,'string',60);
% Update handles structure
flag=0;
handles.flag=flag;


guidata(hObject, handles);
ah=axes('unit','normalized','position',[0 0 1 1]);
bg=imread('voicemonitorBIG.jpg');imagesc(bg);
set(ah,'handlevisibility','off','visible','off')
axes(handles.axes1);    
cla;        %limpiar eje axes3
imshow(MS);
string = sprintf('\n\n  ( ºoº) \n\n             ');
set(handles.et_pitch,'string', string);
pause(1)
    for i=1:3
string = sprintf('\n\n   (>^.^)>\n\n¡Bienvenido! ');
set(handles.et_pitch,'string', string);
pause(0.22)
string = sprintf('\n\n   (>^-^)>\n\n¡Bienvenido! ');
set(handles.et_pitch,'string', string);
pause(0.2)
string = sprintf('\n\n   (>^.^)>\n\n¡Bienvenido! ');
set(handles.et_pitch,'string', string);
pause(0.17)
string = sprintf('\n\n   (>^-^)>\n\n¡Bienvenido! ');
set(handles.et_pitch,'string', string);
pause(0.2)
    end
    for i=1:3
string = sprintf('\n\n      (>^.^)>\n\n¡Elige una opción! ');
set(handles.et_pitch,'string', string);
pause(0.22)
string = sprintf('\n\n      (>^-^)>\n\n¡Elige una opción! ');
set(handles.et_pitch,'string', string);
pause(0.2)
string = sprintf('\n\n      (>^.^)>\n\n¡Elige una opción! ');
set(handles.et_pitch,'string', string);
pause(0.17)
string = sprintf('\n\n      (>^-^)>\n\n¡Elige una opción! ');
set(handles.et_pitch,'string', string);
pause(0.2)
end

%rojo BASE ff1522
%ROJo botones 8d0101
% UIWAIT makes VoiceMonitor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VoiceMonitor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_toanlidad.
function pb_toanlidad_Callback(hObject, eventdata, handles)
% hObject    handle to pb_toanlidad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%CREAR SECUENCIA TONALIDAD
MIDIDATA=handles.MIDIDATA;
tempo=MIDIDATA.tempo;
ts=1/(tempo/60);%formula BPS a SECONDS
first=MIDIDATA.tone;
second=first+4; 
third=first+7;
chordprog=[first,second,third,second,first;ts,ts,ts,ts,ts];  
chord=[first,second,third];
for P=1:length(chordprog)
    midinumber=int2str(chordprog(1,P));
    duration=chordprog(2,P); 
    ext='.mp3';
    file=strcat(midinumber,ext);
    [y,Fs] = audioread(file);
    y=y(:,1);
    sound(y, Fs);
    pause(0.25)
    string = sprintf('\n\n   (>^.^)>\n\nReproduciendo');
set(handles.et_pitch,'string', string);
    pause(0.25)
string = sprintf('\n\n   (>^-^)>\n\nReproduciendo');
set(handles.et_pitch,'string', string);
end
for P=1:length(chord)
    midinumber=int2str(chord(1,P));
    ext='.mp3';
    file=strcat(midinumber,ext);
    [y,Fs] = audioread(file);
    y=y(:,1);
    sound(y, Fs);
    string = sprintf('\n\n   (>^o^)>\n\nReproduciendo');
set(handles.et_pitch,'string', string);
end
 pause(0.8)
clear sound;
for i=1:5
string = sprintf('\n\n        (>^-^)>\n\n¡Selecciona una opción!');
set(handles.et_pitch,'string', string);
pause(0.2)
string = sprintf('\n\n       <(^-^<)\n\n¡Selecciona una opción!');
set(handles.et_pitch,'string', string);
pause(0.2)
end
string = sprintf('\n\n        (>^-^)>\n\n¡Selecciona una opción!');
set(handles.et_pitch,'string', string);
% (>'-')> <('_'<) ^('_')\- \m/(-_-)\m/ <( '-')> \_( .")> <( ._.)-`






function et_pitch_Callback(hObject, eventdata, handles)
% hObject    handle to et_pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_pitch as text
%        str2double(get(hObject,'String')) returns contents of et_pitch as a double


% --- Executes during object creation, after setting all properties.
function et_pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_iniciar.
function pb_iniciar_Callback(hObject, eventdata, handles)
% hObject    handle to pb_iniciar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% (>'-')> <('_'<) ^('_')\- \m/(-_-)\m/ <( '-')> \_( .")> <( ._.)-`
metrica=handles.metrica;
MIDIDATA=handles.MIDIDATA;
global voice;voice = [];
global f0l; f0l=[];
global frame; frame=[];
global notaactual; notaactual=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%PREPARE axes TO GRAPH%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(handles.et_bpm,'string',num2str(MIDIDATA.tempo));
axes(handles.axes2);    
set(gca,'visible','off')
cla;           %limpiar eje axes1
% drawnow       %drawnow updates figures and processes any pending callbacks.
              %used to see the updates on the screen immediately.
% pause(1)      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%% CREATE DAQ SESION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d = daq.getDevices;
dev = d(2);
s = daq.createSession('directsound');
addAudioInputChannel(s, dev.ID, 1);
s.IsContinuous = true
%Data acquisition session using DirectSound hardware:
%Will run continuously at 44100 scans/second until stopped.
d=designfilt('bandstopiir','filterorder',4,'halfpowerfrequency1',4000,...
    'halfpowerfrequency2',7000,'designmethod','butter','samplerate',44100);%originalmente 14hhz

%% filtro pasabandas que debería haber hecho antes :v
Fs = 44100;                                                  % Sampling Frequency (Hz)
Fn = Fs/2;                                                  % Nyquist Frequency (Hz)
Wp = [65   1397]/Fn;                                         % Passband Frequency (Normalised)
Ws = [55   2100]/Fn;                                         % Stopband Frequency (Normalised)
Rp = 1;                                                   % Passband Ripple (dB)
Rs = 5;                                                   % Stopband Ripple (dB)
[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);                             % Filter Order
[z,p,k] = cheby2(n,Rs,Ws);                                  % Filter Design
[sosbp,gbp] = zp2sos(z,p,k);                                % Convert To Second-Order-Section For Stability
% figure(3)
% freqz(sosbp, 2^16, Fs)                                      % Filter Bode Plot
% filtered_signal = filtfilt(sosbp, gbp, original_signal);    % Filter Signal

%%



%filtro para sonidos  "Ss..."
Tnegra=handles.MIDIDATA.Tnegra;


% aqui se podr[ia definir cuantos clicks antes de empezar

% aqui va la seleccion de metrica 
% debe cargarse a "mano" la pista que lleva el tempo
% formato: ['metrica tempo bpm . mp3'] 
% nota: tempo debe tener 3 digitos...   060 090 120 etc...





% procesamiento = @(src, event) Auditive2(event.Data, src.Rate,d); %sin ni miercoles

procesamiento = @(src, event) Auditive2(event.Data, src.Rate,sosbp, gbp); %con filtro pasabandas


hl = addlistener(s, 'DataAvailable', procesamiento);

s.NotifyWhenDataAvailableExceeds =2*round(0.04*s.Rate); %3528 muestras
%Note:The frequency with which the DataAvailable event is fired, is 
%controlled by NotifyWhenDataAvailableExceeds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%% RUN AQUISITION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axes(handles.axes2);
set(gca,'visible','off')
%%%%%%%%%%%%%%%%% COUNT BACK SOUND %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C=[1;2;3]';
image(C);
set(gca,'visible','off')
global currentt
NoteTimes=MIDIDATA.NoteTimes;
cont=1;






if metrica==44 %4/4
[click,Fsclickc] = audioread('44060bpm.mp3');
[yy,Fs] = audioread('44060.wma');
delaycte=3.7;   

elseif metrica==34 %3/4
[click,Fsclickc] = audioread('34060bpm.mp3');
[yy,Fs] = audioread('34060.mp3');
delaycte=3;   

elseif metrica==24 % 2/4
[click,Fsclickc] = audioread('24060bpm.mp3');
[yy,Fs] = audioread('24060.mp3');
delaycte=1.85; 
end
sound(yy,Fs)
pause(delaycte)
sound(click,Fsclickc)
global flag
flag=0;
startBackground(s); %Start acquisition
% movie(mov,1,shuttleAvi.FrameRate)%linea q debe ir dsps del sound q lleva el tempo
% el problema es que el video consume toda la atención de matlab


while (cont<=length(NoteTimes)&flag==0)
    flag=handles.flag;
    if cont~=length(NoteTimes)
        currentt=NoteTimes(cont,1);
        set(handles.et_pitch,'string',midi2note(currentt),'FontSize',70,'FontWeight','bold');
        pause(NoteTimes(cont+1,2)-NoteTimes(cont,2));
        cont=cont+1;
    elseif cont==length(NoteTimes)
        currentt=NoteTimes(cont,1);
        set(handles.et_pitch,'string',midi2note(currentt),'FontSize',70,'FontWeight','bold');
        pause(MIDIDATA.endtime-NoteTimes(cont,2));
        cont=cont+1;
    end
end
clear sound;
stop(s);
s.IsContinuous = false;
delete(hl); %finalizar sesion
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold off  %release plot
voice =[voice frame']; %keep voice vector 


% pause(0.5)
NoteSignal=MIDIDATA.KEY;
t=MIDIDATA.time;
datos.f0l=f0l;
datos.voice=voice;
datos.NoteSignal=NoteSignal;
datos.t=t;
datos.tnegra=MIDIDATA.Tnegra
% handles.datos=datos;

% if flag==0
datos.MIDIDATA=handles.MIDIDATA;
% results(datos,PACK);% modificar la funcion resultados...
% else
% end
handles.datos=datos;
    for i=1:3
string = sprintf('\n\n          (>^.^)>\n\nNo olvides guardar tu sesión');
set(handles.et_pitch,'string', string);
pause(0.22)
string = sprintf('\n\n          (>^.^)>\n\nNo olvides guardar tu sesión');
set(handles.et_pitch,'string', string);
pause(0.2)
string = sprintf('\n\n          (>^.^)>\n\nNo olvides guardar tu sesión');
set(handles.et_pitch,'string', string);
pause(0.17)
string = sprintf('\n\n          (>^.^)>\n\nNo olvides guardar tu sesión');
set(handles.et_pitch,'string', string);
pause(0.2)
end
guidata(hObject, handles);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in pb_aplicar.
function pb_aplicar_Callback(hObject, eventdata, handles)
% hObject    handle to pb_aplicar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% f=get(handles.grouptempo,'SelectedObject');
c=get(handles.groupoctave,'SelectedObject');
d=get(handles.groupsemitone,'SelectedObject');
% XPBM=str2num(get(f,'string'));
XPBM=60;
x=str2num(get(c,'string'));
if x==1
 octava=12;
elseif x==-1
    octava=-12;
else
    octava=0;
end
semitonos=str2num(get(d,'string'));
Tsemitones=semitonos+octava;
handles.Tsemitones=Tsemitones;
midi=handles.midicopy;
[~,endtime,tnegra]=midiInfo(midi);


Notes = midiInfo(midi,0);
INFO=Notes(:,[3 5 6]);
NewNotes=Notes(:,3)+Tsemitones; %remplazar aqui por el valor notes que recibo desde tool/
Notes(:,3)=NewNotes;

Nota=Notes(:,3);
tnegra=round(tnegra*(10^-6),5);
factor=1/tnegra; % para que todo quede en 60bpm
Tataque=Notes(:,5);
Tataque=Tataque*factor;
Tfinal=Notes(:,6);
Tfinal=Tfinal*factor;
endtime=endtime*factor;
tnegra=tnegra*factor;
factor=(1/60)*XPBM; % para que todo quede en 60bpm AQUI VOOOOYYYYYYYYYYYYYYYYY
Tataque=Tataque*factor;
endtime=endtime*factor;
tnegra=tnegra/factor;
NoteTime(:,1)=Nota;
NoteTime(:,2)=Tataque;
NoteTime(:,3)=Tfinal;
tempo=round(60/tnegra);%las operaciones no deben modificar este parametro
MIDIDATA.tempo=tempo;
MIDIDATA.KEY=Nota;%vector de numeros midi 
MIDIDATA.time=Tataque;        %vector tiempo asociado
MIDIDATA.tone=MIDIDATA.KEY(1);
MIDIDATA.midi=midi;
MIDIDATA.NoteTimes=NoteTime;
MIDIDATA.Tnegra=tnegra;
MIDIDATA.endtime=endtime;
handles.MIDIDATA=MIDIDATA;
guidata(hObject, handles);
set(handles.et_bpm,'string',60);
for i=1:7
string = sprintf('\n\n     (>^-^)>\n\n ¡Buena elección!');
set(handles.et_pitch,'string', string);
pause(0.17)
string = sprintf('\n\n     (>._.)>\n\n ¡Buena elección!');
set(handles.et_pitch,'string', string);
pause(0.2)
end
string = sprintf('\n\n        (>^-^)>\n\n¡Selecciona una opción!');
set(handles.et_pitch,'string', string);
% (>'-')> <('_'<) ^('_')\- \m/(-_-)\m/ <( '-')> \_( .")> <( ._.)-`



function et_bpm_Callback(hObject, eventdata, handles)
% hObject    handle to et_bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et_bpm as text
%        str2double(get(hObject,'String')) returns contents of et_bpm as a double


% --- Executes during object creation, after setting all properties.
function et_bpm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_bpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)



valor=get(hObject,'value');
set(handles.texto,'string',num2str(valor));
handles.valor=valor;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pb_guardar.
function pb_guardar_Callback(hObject, eventdata, handles)
% hObject    handle to pb_guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
datos=handles.datos;
uisave('datos','sesion')
catch
    for i=1:3
string = sprintf('\n\n             (>^.^)>\n\n¡Coser y cantar; todo es empezar ');
set(handles.et_pitch,'string', string);
pause(0.22)
string = sprintf('\n\n             (>^-^)>\n\n¡Coser y cantar; todo es empezar ');
set(handles.et_pitch,'string', string);
pause(0.2)
string = sprintf('\n\n             (>^.^)>\n\n¡Coser y cantar; todo es empezar ');
set(handles.et_pitch,'string', string);
pause(0.17)
string = sprintf('\n\n             (>^-^)>\n\n¡Coser y cantar; todo es empezar ');
set(handles.et_pitch,'string', string);
pause(0.2)
    end
    for i=1:3
string = sprintf('\n\n            (>^.^)>\n\n¡Presiona INICIAR para cantar! ');
set(handles.et_pitch,'string', string);
pause(0.22)
string = sprintf('\n\n            (>^-^)>\n\n¡Presiona INICIAR para cantar! ');
set(handles.et_pitch,'string', string);
pause(0.2)
string = sprintf('\n\n            (>^.^)>\n\n¡Presiona INICIAR para cantar! ');
set(handles.et_pitch,'string', string);
pause(0.17)
string = sprintf('\n\n            (>^-^)>\n\n¡Presiona INICIAR para cantar! ');
set(handles.et_pitch,'string', string);
pause(0.2)
end
string = sprintf('\n\n            (>^.^)>\n\n¡Presiona INICIAR para cantar! ');
set(handles.et_pitch,'string', string);
string = sprintf('\n\n        (>^-^)>\n\n Selecciona una opción ');
set(handles.et_pitch,'string', string);
end


% --- Executes on button press in rb_x4.
function rb_x4_Callback(hObject, eventdata, handles)
% hObject    handle to rb_x4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_x4


% --- Executes on button press in rb_x2.
function rb_x2_Callback(hObject, eventdata, handles)
% hObject    handle to rb_x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_x2


% --- Executes on button press in rb_x1.
function rb_x1_Callback(hObject, eventdata, handles)
% hObject    handle to rb_x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_x1


% --- Executes on button press in radiobutton100.
function radiobutton100_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton100 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton100


% --- Executes on button press in pb_stop.
function pb_stop_Callback(hObject, eventdata, handles)
% hObject    handle to pb_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag
flag=1;
handles.flag=flag;
guidata(hObject,handles);
drawnow


% --- Executes on button press in pb_resume.
function pb_resume_Callback(hObject, eventdata, handles)
% hObject    handle to pb_resume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PACK=handles.PACK;
try
datos=handles.datos;
results(datos,PACK);% modificar la funcion resultados...
catch
for i=1:5
string = sprintf('\n\n       (>^.^)>\n\n¡No has cantado aùn! ');
set(handles.et_pitch,'string', string);
pause(0.2)
string = sprintf('\n\n      <(^.^<)\n\n¡No has cantado aùn! ');
set(handles.et_pitch,'string', string);
pause(0.2)
end
for i=1:3
string = sprintf('\n\n            (>^.^)>\n\n¡Presiona INICIAR para cantar! ');
set(handles.et_pitch,'string', string);
pause(0.22)
string = sprintf('\n\n            (>^-^)>\n\n¡Presiona INICIAR para cantar! ');
set(handles.et_pitch,'string', string);
pause(0.2)
string = sprintf('\n\n            (>^.^)>\n\n¡Presiona INICIAR para cantar! ');
set(handles.et_pitch,'string', string);
pause(0.17)
string = sprintf('\n\n            (>^-^)>\n\n¡Presiona INICIAR para cantar! ');
set(handles.et_pitch,'string', string);
pause(0.2)
end
string = sprintf('\n\n            (>^.^)>\n\n¡Presiona INICIAR para cantar! ');
set(handles.et_pitch,'string', string);
string = sprintf('\n\n        (>^-^)>\n\n¡Selecciona una opción!');
set(handles.et_pitch,'string', string);
end

% --- Executes on button press in pb_back.
function pb_back_Callback(hObject, eventdata, handles)
% hObject    handle to pb_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    for i=1:3
string = sprintf('\n\n   (>^.^)>\n\n¡Hasta pronto!');
set(handles.et_pitch,'string', string);
pause(0.22)
string = sprintf('\n\n   (>^-^)7\n\n¡Hasta pronto!');
set(handles.et_pitch,'string', string);
pause(0.2)
string = sprintf('\n\n   (>^.^)>\n\n¡Hasta pronto!');
set(handles.et_pitch,'string', string);
pause(0.17)
string = sprintf('\n\n   (>^-^)7\n\n¡Hasta pronto!');
set(handles.et_pitch,'string', string);
pause(0.2)
end
hf=findobj('Name','VoiceMonitor');
close(hf)
main_menu()

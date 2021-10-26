function varargout = main_menu(varargin)
% MAIN_MENU MATLAB code for main_menu.fig
%      MAIN_MENU, by itself, creates a new MAIN_MENU or raises the existing
%      singleton*.
%
%      H = MAIN_MENU returns the handle to a new MAIN_MENU or the handle to
%      the existing singleton*.
%
%      MAIN_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_MENU.M with the given input arguments.
%
%      MAIN_MENU('Property','Value',...) creates a new MAIN_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_menu

% Last Modified by GUIDE v2.5 05-Nov-2019 00:50:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_menu_OpeningFcn, ...
                   'gui_OutputFcn',  @main_menu_OutputFcn, ...
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


% --- Executes just before main_menu is made visible.
function main_menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_menu (see VARARGIN)
% addpath('C:\Users\ASUS\Dropbox\2019-2 - Danny Lasso\MATLAB\monitor_final v1.2\GUI\MIDI'); %% poner aqui la ruta de la carpeta MIDI q contiene la toolbox de midi  HOME
% cedula=varargin{1};
try
hf=findobj('Name','iniciar');
close(hf)
catch
end

try
hf=findobj('Name','results');
close(hf)
catch
end
% x=[cedula '.mat'];
% name=load(x, 'nombre');
% s = [name.nombre];
% set(handles.st_saludo,'string',s)
ah=axes('unit','normalized','position',[0 0 1 1]);
bg=imread('mainmenu2.jpg');imagesc(bg);
set(ah,'handlevisibility','off','visible','off')

% Choose default command line output for main_menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
guidata(hObject, handles);
ah=axes('unit','normalized','position',[0 0 1 1]);
bg=imread('mainmenu2.jpg');imagesc(bg);
set(ah,'handlevisibility','off','visible','off')
% UIWAIT makes main_menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pb_open_previous_session.
function pb_open_previous_session_Callback(hObject, eventdata, handles)
% hObject    handle to pb_open_previous_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile({'*.mat'});
addpath(path);

if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
   datos=load(file);
   datos=datos.datos;
   results(datos);
end

% --- Executes on button press in pb_validar.
function pb_validar_Callback(hObject, eventdata, handles)
% hObject    handle to pb_validar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_read_file.
function pb_read_file_Callback(hObject, eventdata, handles)
% hObject    handle to pb_read_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile({'*.mid'});
addpath(path); %% poner aqui la ruta de la carpeta MIDI q contiene la toolbox de midi

if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['Usted seleccionó ', fullfile(path,file)]);
   midi = readmidi(file);
%%%%%midi midi midi ** FEATURE EXTRACTION **midi midi midi midi%%%%
L = strlength(file);
endcut=L-4;
startcut=L-5;
metrica = str2double(extractBetween(file,startcut,endcut));
handles.metrica=metrica;
[Notes,endtime,tnegra]=midiInfo(midi);

Nota=Notes(:,3);
tnegra=round(tnegra*(10^-6),5);
factor=1/tnegra; % para que todo quede en 60bpm 
Tataque=Notes(:,5);
Tataque=Tataque*factor;
Tfinal=Notes(:,6);
Tfinal=Tfinal*factor;
endtime=endtime*factor;
tnegra=tnegra*factor;
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
MIDIDATA.factortempo=factor;
MIDIDATA.endtime=endtime;
handles.MIDIDATA=MIDIDATA;


%Recibir imagen partitura

C = strsplit(file,'.');
   C=C(1);
   s2 = '.jpg';
   s = strcat(C,s2);
   s= string(s); 
   MS = imread(s); 
   handles.MS=MS;
end



guidata(hObject,handles)

% --- Executes on button press in pb_InicioSesion.
function pb_InicioSesion_Callback(hObject, eventdata, handles)
% hObject    handle to pb_InicioSesion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MIDIDATA=handles.MIDIDATA;
MS=handles.MS;
metrica=handles.metrica;

VoiceMonitor(MIDIDATA,MS,metrica);

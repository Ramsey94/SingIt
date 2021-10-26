function varargout = iniciar(varargin)
% INICIAR MATLAB code for iniciar.fig
%      INICIAR, by itself, creates a new INICIAR or raises the existing
%      singleton*.
%
%      H = INICIAR returns the handle to a new INICIAR or the handle to
%      the existing singleton*.
%
%      INICIAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INICIAR.M with the given input arguments.
%
%      INICIAR('Property','Value',...) creates a new INICIAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before iniciar_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to iniciar_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help iniciar

% Last Modified by GUIDE v2.5 19-Apr-2020 21:55:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @iniciar_OpeningFcn, ...
                   'gui_OutputFcn',  @iniciar_OutputFcn, ...
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


% --- Executes just before iniciar is made visible.
function iniciar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to iniciar (see VARARGIN)

% Choose default command line output for iniciar
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes iniciar wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = iniciar_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
main_menu()

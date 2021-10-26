function varargout = usser_info(varargin)
% USSER_INFO MATLAB code for usser_info.fig
%      USSER_INFO, by itself, creates a new USSER_INFO or raises the existing
%      singleton*.
%
%      H = USSER_INFO returns the handle to a new USSER_INFO or the handle to
%      the existing singleton*.
%
%      USSER_INFO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USSER_INFO.M with the given input arguments.
%
%      USSER_INFO('Property','Value',...) creates a new USSER_INFO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before usser_info_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to usser_info_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES


% Edit the above text to modify the response to help usser_info


% Last Modified by GUIDE v2.5 20-Nov-2019 03:51:38


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @usser_info_OpeningFcn, ...
                   'gui_OutputFcn',  @usser_info_OutputFcn, ...
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




% --- Executes just before usser_info is made visible.
function usser_info_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to usser_info (see VARARGIN)


% Choose default command line output for usser_info
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);
ah=axes('unit','normalized','position',[0 0 1 1]);
bg=imread('usserinfo.jpg');imagesc(bg);
set(ah,'handlevisibility','off','visible','off')

% UIWAIT makes usser_info wait for user response (see UIRESUME)
% uiwait(handles.figure1);




% --- Outputs from this function are returned to the command line.
function varargout = usser_info_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get default command line output from handles structure
varargout{1} = handles.output;






function et_name_Callback(hObject, eventdata, handles)
% hObject    handle to et_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of et_name as text
%        str2double(get(hObject,'String')) returns contents of et_name as a double




% --- Executes during object creation, after setting all properties.
function et_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function et_cedula_Callback(hObject, eventdata, handles)
% hObject    handle to et_cedula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of et_cedula as text
%        str2double(get(hObject,'String')) returns contents of et_cedula as a double




% --- Executes during object creation, after setting all properties.
function et_cedula_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_cedula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function et_registrovocal_Callback(hObject, eventdata, handles)
% hObject    handle to et_registrovocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of et_registrovocal as text
%        str2double(get(hObject,'String')) returns contents of et_registrovocal as a double




% --- Executes during object creation, after setting all properties.
function et_registrovocal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_registrovocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pb_intro_info.
function pb_intro_info_Callback(hObject, eventdata, handles)
% hObject    handle to pb_intro_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ID=get(handles.et_cedula,'string');
nombre=get(handles.et_name,'string');
score_vector=[];
save(ID,'ID','nombre','score_vector');
main_menu(ID);






function et_name2_Callback(hObject, eventdata, handles)
% hObject    handle to et_name2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of et_name2 as text
%        str2double(get(hObject,'String')) returns contents of et_name2 as a double




% --- Executes during object creation, after setting all properties.
function et_name2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et_name2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = gui_rekomendasi(varargin)
% GUI_REKOMENDASI MATLAB code for gui_rekomendasi.fig
%      GUI_REKOMENDASI, by itself, creates a new GUI_REKOMENDASI or raises the existing
%      singleton*.
%
%      H = GUI_REKOMENDASI returns the handle to a new GUI_REKOMENDASI or the handle to
%      the existing singleton*.
%
%      GUI_REKOMENDASI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_REKOMENDASI.M with the given input arguments.
%
%      GUI_REKOMENDASI('Property','Value',...) creates a new GUI_REKOMENDASI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_rekomendasi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_rekomendasi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_rekomendasi

% Last Modified by GUIDE v2.5 02-Jul-2021 13:22:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_rekomendasi_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_rekomendasi_OutputFcn, ...
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

% --- Executes just before gui_rekomendasi is made visible.
function gui_rekomendasi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_rekomendasi (see VARARGIN)

% Choose default command line output for gui_rekomendasi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_rekomendasi wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = gui_rekomendasi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%Proses Import Dataset
format long g;

opts = detectImportOptions('datasetpb.xlsx');
opts.SelectedVariableNames = (2);
data1 = readmatrix('datasetpb.xlsx',opts);

opts = detectImportOptions('datasetpb.xlsx');
opts.SelectedVariableNames = (3);
data2 = readmatrix('datasetpb.xlsx',opts);

opts = detectImportOptions('datasetpb.xlsx');
opts.SelectedVariableNames = (4:5);
data3 = readmatrix('datasetpb.xlsx',opts);
x = [data1/1000 data2/1000 data3];

%Proses Fuzzy
[m n]=size (x); %matriks m x n dengan ukuran sebanyak variabel x (input)
for i=1:m,
    fis = readfis('powerbank');
    V(i)= evalfis(fis,x(i,:));
end;

%Proses memberi rekomendasi berdasarkan hasil evalfis
reco = strings(m,1);
skorfis = strings(m,1);
for q=1:m,
    if V(q) <= 2
        reco(q)="Tidak Direkomendasikan";
    elseif V(q) > 2 && V(q) <= 3
        reco(q)="Direkomendasikan";
    elseif V(q) > 3
        reco(q)="Sangat Direkomendasikan";
    end
    skorfis(q) = V(q);
end;

%Proses output hasil ke uitable
reco=cellstr(reco);
opts = detectImportOptions('datasetpb.xlsx');
opts.SelectedVariableNames = (1);
namapb = readmatrix('datasetpb.xlsx',opts);
skorfis=cellstr(skorfis);
reco=[namapb reco skorfis];
set(handles.uitable1,'data', reco);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in tab1.
function tab1_Callback(hObject, eventdata, handles)
% hObject    handle to tab1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel1, 'visible','on')
set(handles.uipanel2, 'visible','off')

% --- Executes on button press in tab2.
function tab2_Callback(hObject, eventdata, handles)
% hObject    handle to tab2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel1, 'visible','on')
set(handles.uipanel2, 'visible','on')

function harga_Callback(hObject, eventdata, handles)
% hObject    handle to harga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of harga as text
%        str2double(get(hObject,'String')) returns contents of harga as a double
Harga=str2double(get(hObject,'string'));
handles.Harga=Harga;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function harga_CreateFcn(hObject, eventdata, handles)
% hObject    handle to harga (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function kapasitas_Callback(hObject, eventdata, handles)
% hObject    handle to kapasitas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kapasitas as text
%        str2double(get(hObject,'String')) returns contents of kapasitas as a double
Kapasitas=str2double(get(hObject,'string'));
handles.Kapasitas=Kapasitas;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function kapasitas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kapasitas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function watt_Callback(hObject, eventdata, handles)
% hObject    handle to watt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of watt as text
%        str2double(get(hObject,'String')) returns contents of watt as a double
Watt=str2double(get(hObject,'string'));
handles.Watt=Watt;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function watt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to watt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function usb_Callback(hObject, eventdata, handles)
% hObject    handle to usb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of usb as text
%        str2double(get(hObject,'String')) returns contents of usb as a double
Usb=str2double(get(hObject,'string'));
handles.Usb=Usb;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function usb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to usb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rekomendasi_Callback(hObject, eventdata, handles)
% hObject    handle to rekomendasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rekomendasi as text
%        str2double(get(hObject,'String')) returns contents of rekomendasi as a double

% --- Executes during object creation, after setting all properties.
function rekomendasi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rekomendasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=readfis('powerbank')
out=evalfis([handles.Harga/1000, handles.Kapasitas/1000, handles.Watt, handles.Usb],a)
set(handles.rekomendasi,'string',out);
if out == 2.5
    set(handles.status,'String','OUT OF RANGE');
    set(handles.rekomendasi,'string','Input diluar jangkauan');
elseif out <= 2
    set(handles.status,'String','Tidak Direkomendasikan');
elseif out > 2 && out <= 3
    set(handles.status,'String','Direkomendasikan');
elseif out > 3
    set(handles.status,'String','Sangat Direkomendasikan');
end

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.harga,'string','');
set(handles.kapasitas,'string','');
set(handles.watt,'string','');
set(handles.usb,'string','');
set(handles.rekomendasi,'string','');
set(handles.status,'string','');

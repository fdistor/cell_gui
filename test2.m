function varargout = test2(varargin)
% TEST2 MATLAB code for test2.fig
%      TEST2, by itself, creates a new TEST2 or raises the existing
%      singleton*.
%
%      H = TEST2 returns the handle to a new TEST2 or the handle to
%      the existing singleton*.
%
%      TEST2('CALLBACK',hObject,eventData,h,...) calls the local
%      function named CALLBACK in TEST2.M with the given input arguments.
%
%      TEST2('Property','Value',...) creates a new TEST2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIh

% Edit the above text to modify the response to help test2

% Last Modified by GUIDE v2.5 21-Oct-2015 14:13:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @test2_OpeningFcn, ...
    'gui_OutputFcn',  @test2_OutputFcn, ...
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


% --- Executes just before test2 is made visible.
function test2_OpeningFcn(hObject, eventdata, h, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
% varargin   command line arguments to test2 (see VARARGIN)

% Choose default command line output for test2
h.output = hObject;
set(h.radp1,'Value',1)
% Update h structure
guidata(hObject, h);

% UIWAIT makes test2 wait for user response (see UIRESUME)
% uiwait(h.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test2_OutputFcn(hObject, eventdata, h)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)

% Get default command line output from h structure
varargout{1} = h.output;


% --- Executes on button press in LoadButton.
function LoadButton_Callback(hObject, eventdata, h)
% hObject    handle to LoadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
a = get(h.rad1,'Value');
b = get(h.rad2,'Value');
c = get(h.rad3,'Value');
startFolder = 'K:\ProcessedData';                                           %Starting file location.
% startFolder = 'D:\Program Files (x86)\MATLAB\R2013a Student\bin\MATLAB files\Albeck';
defaultFileName = fullfile(startFolder,'*.mat');
[FileName,FilePath] = uigetfile(defaultFileName,'Select .mat file.');       %Retrieve .mat name and path.
if isequal(FileName,0) || isequal(FilePath,0)
    disp('File not selected.');                                             %Displays if user cancels the file load prompt.
else
    sprintf('Loaded file is %s.\n\n',FileName);                             %Shows the name of the file loaded into h.file.
    fullFileName = fullfile(FilePath,FileName);
    if a == 1
        h.file1 = load(fullFileName);
        if isfield(h.file1,'valcube') == 0
            disp('This file does NOT have a ''valcube'' matrix.')
        else
            [cell,time,chan] = size(h.file1.valcube);
            h.maxCell1 = cell; h.maxChan1 = chan;
            h.maxTime1 = time;
            set(h.maxCtext,'String',num2str(h.maxCell1));
            set(h.textF1,'String',FileName);
            set(h.textHmax,'String', num2str(h.maxChan1));
            set(h.cellSlide,'Max',h.maxCell1);
            set(h.channelSlide,'Max',h.maxChan1);
        end
    elseif b == 1
        h.file2 = load(fullFileName);
        if isfield(h.file2,'valcube') == 0
            disp('This file does NOT have a ''valcube'' matrix.')
        else
            [cell,time,chan] = size(h.file2.valcube);
            h.maxCell2 = cell; h.maxChan2 = chan;
            h.maxTime2 = time;
            set(h.maxCtext,'String',num2str(h.maxCell2));
            set(h.textF2,'String',FileName);
            set(h.textHmax,'String', num2str(h.maxChan2));
            set(h.cellSlide,'Max',h.maxCell2);
            set(h.channelSlide,'Max',h.maxChan2);
        end
    elseif c == 1
        h.file3 = load(fullFileName);
        if isfield(h.file3,'valcube') == 0
            disp('This file does NOT have a ''valcube'' matrix.')
        else
            [cell,time,chan] = size(h.file3.valcube);
            h.maxCell3 = cell; h.maxChan3 = chan;
            h.maxTime3 = time;
            set(h.maxCtext,'String',num2str(h.maxCell3));
            set(h.textF3,'String',FileName);
            set(h.textHmax,'String', num2str(h.maxChan3));
            set(h.cellSlide,'Max',h.maxCell3);
            set(h.channelSlide,'Max',h.maxChan3);
        end
    end
    set(h.cellSlide,'Min',1);
    set(h.channelSlide,'Min',1);
    set(h.cellSlide,'Value',1);
    set(h.channelSlide,'Value',1);
    set(h.cellEdit,'String',1);
    set(h.channelEdit,'String',1);
end
guidata(hObject,h)


% --- Executes on button press in PlotButton.
function PlotButton_Callback(hObject, eventdata, h)
% hObject    handle to PlotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
amp = h.file.valcube(h.cellNum,:,h.channelNum);
time = 1:length(amp);
maxAmp = max(amp)+max(amp)/20;
axes(h.axes1)
plot(time,amp)
cellTitle = sprintf('Cell %.f, Channel %.f',h.cellNum, ...
    h.channelNum);
title(cellTitle)
xlabel('Time [6 mins]'), ylabel('Intensity')
% xlim([0 length(amp)])
% ylim([0 maxAmp])

% plot(time,amp);
% if exist(h.file.valcube) & exist(h.cellEdit) & ...
%         exist(h.channelEdit) == 1
% plot(h.axes1,h.file.valcube(h.cellEdit,:,...
%     h.channelEdit),1:h.maxTime)
guidata(hObject,h)
% else
%     disp('Please load a valid file.')
% end

% --- Executes on slider movement.
function cellSlide_Callback(hObject, eventdata, h)
% hObject    handle to cellSlide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
a = get(h.rad1,'Value');
b = get(h.rad2,'Value');
c = get(h.rad3,'Value');
if a == 1
    if isfield(h,'maxCell1') == 1
        set(h.cellSlide,'Max',h.maxCell1);
        set(h.cellSlide,'SliderStep',[1/h.maxCell1 ...
            25/h.maxCell1])
    else
        disp('Please load a .mat file in File 1 before moving this slider.')
    end
    h.cellNum1 = round(get(hObject,'Value'));
    if h.cellNum1 < 0
        set(h.cellSlide,'Value',1);
        h.cellNum1 = 1;
    end
    set(h.cellEdit,'String',num2str(ceil(get(hObject,'Value'))));
    set(h.textC1,'String',num2str(ceil(get(hObject,'Value'))));
end
if b == 1
    if isfield(h,'maxCell2') == 1
        set(h.cellSlide,'Max',h.maxCell2);
        set(h.cellSlide,'SliderStep',[1/h.maxCell2 ...
            25/h.maxCell2])
    else
        disp('Please load a .mat file in File 2 before moving this slider.')
    end
    h.cellNum2 = round(get(hObject,'Value'));
    if h.cellNum2 < 0
        set(h.cellSlide,'Value',1);
        h.cellNum2 = 1;
    end
    set(h.cellEdit,'String',num2str(ceil(get(hObject,'Value'))));
    set(h.textC2,'String',num2str(ceil(get(hObject,'Value'))));
end
if c == 1
    if isfield(h,'maxCell3') == 1
        set(h.cellSlide,'Max',h.maxCell3);
        set(h.cellSlide,'SliderStep',[1/h.maxCell3 ...
            25/h.maxCell3])
    else
        disp('Please load a .mat file before moving this slider.')
    end
    h.cellNum3 = round(get(hObject,'Value'));
    if h.cellNum3 < 0
        set(h.cellSlide,'Value',1);
        h.cellNum3 = 1;
    end
    set(h.cellEdit,'String',num2str(ceil(get(hObject,'Value'))));
    set(h.textC3,'String',num2str(ceil(get(hObject,'Value'))));
end
% fprintf('Cell %.f chosen.\n',h.cellNum)
guidata(hObject,h)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function cellSlide_CreateFcn(hObject, eventdata, h)
% hObject    handle to cellSlide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    empty - h not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
guidata(hObject,h)



function cellEdit_Callback(hObject, eventdata, h)
% hObject    handle to cellEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
a = get(h.rad1,'Value');
b = get(h.rad2,'Value');
c = get(h.rad3,'Value');
if a == 1
    h.cellNum1 = str2num(get(hObject,'String'));
    set(h.cellSlide,'Value',h.cellNum1);
    set(h.textC1,'String',num2str(h.cellNum1));
    guidata(hObject,h);
elseif b == 1
    h.cellNum2 = str2num(get(hObject,'String'));
    set(h.cellSlide,'Value',h.cellNum2);
    set(h.textC2,'String',num2str(h.cellNum2));
    guidata(hObject,h);
elseif c == 1
    h.cellNum3 = str2num(get(hObject,'String'));
    set(h.cellSlide,'Value',h.cellNum3);
    set(h.textC3,'String',num2str(h.cellNum3));
    guidata(hObject,h);    
end
guidata(hObject,h)
% Hints: get(hObject,'String') returns contents of cellEdit as text
%        str2double(get(hObject,'String')) returns contents of cellEdit as a double


% --- Executes during object creation, after setting all properties.
function cellEdit_CreateFcn(hObject, eventdata, h)
% hObject    handle to cellEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    empty - h not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject,h)


% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, h)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)



function channelEdit_Callback(hObject, eventdata, h)
% hObject    handle to channelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
a = get(h.rad1,'Value');
b = get(h.rad2,'Value');
c = get(h.rad3,'Value');
if a == 1
    h.channelNum1 = ceil(str2num(get(hObject,'String')));
    if h.channelNum1 > h.maxChan1
        h.channelNum1 = h.maxChan1;
    elseif h.channelNum1 < 1
        h.channelNum1 = 1;
    end
    set(h.textH1,'String',num2str(h.channelNum1));
    set(h.channelSlide,'Value',h.channelNum1);
end
% % if isinteger(str2double(get(hObject,'String'))) == 1
% %     h.channelNum = str2double(get(hObject,'String'));
% %     disp(h.channelNum)
% % else
% %     if isfield(h,'maxChan') == 1
% %     sprintf('Please enter a number between 1 and %s before proceeding.\n',num2str(h.maxChan))
% %     else
% %         disp('Please load a .MAT file before continuing.')
% %     end
% % end
guidata(hObject,h)

% Hints: get(hObject,'String') returns contents of channelEdit as text
%        str2double(get(hObject,'String')) returns contents of channelEdit as a double


% --- Executes during object creation, after setting all properties.
function channelEdit_CreateFcn(hObject, eventdata, h)
% hObject    handle to channelEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    empty - h not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rad1.
function rad1_Callback(hObject, eventdata, h)
% hObject    handle to rad1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
set(hObject,'Value',1)
set(h.rad2,'Value',0)
set(h.rad3,'Value',0)
guidata(hObject,h)
% Hint: get(hObject,'Value') returns toggle state of rad1


% --- Executes on button press in rad2.
function rad2_Callback(hObject, eventdata, h)
% hObject    handle to rad2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
set(hObject,'Value',1)
set(h.rad1,'Value',0)
set(h.rad3,'Value',0)
guidata(hObject,h)
% Hint: get(hObject,'Value') returns toggle state of rad2


% --- Executes on button press in rad3.
function rad3_Callback(hObject, eventdata, h)
% hObject    handle to rad3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
set(hObject,'Value',1)
set(h.rad2,'Value',0)
set(h.rad1,'Value',0)
guidata(hObject,h)
% Hint: get(hObject,'Value') returns toggle state of rad3


% --- Executes on slider movement.
function channelSlide_Callback(hObject, eventdata, h)
% hObject    handle to channelSlide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
a = get(h.rad1,'Value');
b = get(h.rad2,'Value');
c = get(h.rad3,'Value');
g1 = ishandle(h.axes1); g2 = ishandle(h.axes2);
r1 = get(h.radp1,'Value'); r2 = get(h.radp2,'Value');
bm1 = get(h.boxm1,'Value'); b1 = get(h.box1,'Value');
bm2 = get(h.boxm2,'Value'); b2 = get(h.box2,'Value');
bm3 = get(h.boxm3,'Value'); b3 = get(h.box3,'Value');
if a == 1
    if isfield(h,'maxChan1') == 1
        set(h.channelSlide,'Max',h.maxChan1);
        set(h.channelSlide,'SliderStep',[1/h.maxChan1 ...
            5/h.maxChan1])
    else
        disp('Please load a .mat file in File 1 before moving this slider.')
    end
    h.channelNum1 = round(get(hObject,'Value'));
    if h.channelNum1 < 0
        set(h.channelSlide,'Value',1);
        h.channelNum1 = 1;
    elseif h.channelNum1 > h.maxChan1
        set(h.channelSlide,'Value',1);
        h.channelNum1 = 12;
    end
    set(h.channelEdit,'String',num2str(ceil(get(hObject,'Value'))));
    set(h.textH1,'String',num2str(ceil(get(hObject,'Value'))));
%     if g1 == 1 || g2 == 1
%         if r1 == 1
%             axes(h.axes1)
%             hold on
%             
%         elseif r2 == 1
end
if b == 1
    if isfield(h,'maxCell2') == 1
        set(h.cellSlide,'Max',h.maxCell2);
        set(h.cellSlide,'SliderStep',[1/h.maxCell2 ...
            5/h.maxCell2])
    else
        disp('Please load a .mat file in File 2 before moving this slider.')
    end
    h.cellNum2 = round(get(hObject,'Value'));
    if h.cellNum2 < 0
        set(h.cellSlide,'Value',1);
        h.cellNum2 = 1;
    end
    set(h.cellEdit,'String',num2str(ceil(get(hObject,'Value'))));
    set(h.textC2,'String',num2str(ceil(get(hObject,'Value'))));
end
if c == 1
    if isfield(h,'maxCell3') == 1
        set(h.cellSlide,'Max',h.maxCell3);
        set(h.cellSlide,'SliderStep',[1/h.maxCell3 ...
            25/h.maxCell3])
    else
        disp('Please load a .mat file before moving this slider.')
    end
    h.cellNum3 = round(get(hObject,'Value'));
    if h.cellNum3 < 0
        set(h.cellSlide,'Value',1);
        h.cellNum3 = 1;
    end
    set(h.cellEdit,'String',num2str(ceil(get(hObject,'Value'))));
    set(h.textC3,'String',num2str(ceil(get(hObject,'Value'))));
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function channelSlide_CreateFcn(hObject, eventdata, h)
% hObject    handle to channelSlide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    empty - h not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in boxm1.
function boxm1_Callback(hObject, eventdata, h)
% hObject    handle to boxm1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
if get(hObject,'Value') == 1
    if isfield(h,'file1') == 1
        for i = 1:h.maxTime1
            h.mean1(i) = nanmean2(h.file1.valcube(:,:,i));
            size(h.mean1)
        end
    end
else
    if isfield(h,'mean1') == 1
        h.mean1 = [];
    end
end
% Hint: get(hObject,'Value') returns toggle state of boxm1


% --- Executes on button press in box1.
function box1_Callback(hObject, eventdata, h)
% hObject    handle to box1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of box1


% --- Executes on button press in box2.
function box2_Callback(hObject, eventdata, h)
% hObject    handle to box2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of box2


% --- Executes on button press in box3.
function box3_Callback(hObject, eventdata, h)
% hObject    handle to box3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of box3


% --- Executes on button press in radp1.
function radp1_Callback(hObject, eventdata, h)
% hObject    handle to radp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
set(hObject,'Value',1)
set(h.radp2,'Value',0)
% Hint: get(hObject,'Value') returns toggle state of radp1


% --- Executes on button press in radp2.
function radp2_Callback(hObject, eventdata, h)
% hObject    handle to radp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)
set(hObject,'Value',1)
set(h.radp1,'Value',0)
% Hint: get(hObject,'Value') returns toggle state of radp2



function ymin_Callback(hObject, eventdata, h)
% hObject    handle to ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ymin as text
%        str2double(get(hObject,'String')) returns contents of ymin as a double


% --- Executes during object creation, after setting all properties.
function ymin_CreateFcn(hObject, eventdata, h)
% hObject    handle to ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    empty - h not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xmax_Callback(hObject, eventdata, h)
% hObject    handle to xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xmax as text
%        str2double(get(hObject,'String')) returns contents of xmax as a double


% --- Executes during object creation, after setting all properties.
function xmax_CreateFcn(hObject, eventdata, h)
% hObject    handle to xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    empty - h not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymax_Callback(hObject, eventdata, h)
% hObject    handle to ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ymax as text
%        str2double(get(hObject,'String')) returns contents of ymax as a double


% --- Executes during object creation, after setting all properties.
function ymax_CreateFcn(hObject, eventdata, h)
% hObject    handle to ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    empty - h not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xmin_Callback(hObject, eventdata, h)
% hObject    handle to xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xmin as text
%        str2double(get(hObject,'String')) returns contents of xmin as a double


% --- Executes during object creation, after setting all properties.
function xmin_CreateFcn(hObject, eventdata, h)
% hObject    handle to xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    empty - h not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in boxm2.
function boxm2_Callback(hObject, eventdata, h)
% hObject    handle to boxm2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of boxm2


% --- Executes on button press in boxm3.
function boxm3_Callback(hObject, eventdata, h)
% hObject    handle to boxm3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% h    structure with h and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of boxm3

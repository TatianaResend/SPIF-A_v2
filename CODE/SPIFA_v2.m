% Code of SPIFA_v2
clear, clc

% -----------------------------------------------------
% Initialization of app
% -----------------------------------------------------
SPIF = app1; 
drawnow;                % Update the display (Open app)
while ~isvalid(SPIF)    % Wait for the app to be created and become valid
    pause(0.1); 
end

% -----------------------------------------------------
% Communication with ARDUINO
% -----------------------------------------------------
while SPIF.Connect == 0
    pause(0.1)
end

PortaCOM = SPIF.PortaCOMDropDown.Value;
   
% Connect to the Arduino board
ard = arduino(PortaCOM, 'Uno');
disp('Arduino on ' + string(PortaCOM) + ' Port')
while SPIF.GO == 0
    pause(0.1)
end

Xcordinate = SPIF.coordinateXEditField.Value;
disp('RUN')
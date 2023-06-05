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

while 1
    PortaCOM = SPIF.COMPortDropDown.Value;
    try
       %ard = arduino(PortaCOM, 'Uno');          % Connect to the Arduino board
       arduinoCom=serial(PortaCOM,'BAUD', 9600);
       fopen(arduinoCom); %open the port
       disp('Arduino on ' + string(PortaCOM) + ' Port')
       break
    catch 
        disp('Error opening port ' + string(PortaCOM) + ', confirm that it is correct')
    end
end


% -----------------------------------------------------
% Wait for the command
% -----------------------------------------------------

while true
    switch SPIF.Command
        case 'RUN'   
            % Reception of coordinates (x,y,z)
            Xcordinate = SPIF.coordinateXEditField.Value;
            Ycordinate = SPIF.coordinateYEditField.Value;
            Zcordinate = SPIF.coordinateZEditField.Value;
        
            % Conversion of (y,z) to (theta1,theta 2)
            [theta1,theta2] = Get_theta1_theta2(Ycordinate,Zcordinate);
            a = [theta1,theta2];

            % Send to the Arduino
            fwrite(arduinoCom,num2str(a))
            pause(2)
            fscanf(arduinoCom)
            SPIF.Command = '';

        case 'HOME'
            disp('Move to HOME')
            fwrite(arduinoCom,string(1))
            pause(2)
            fscanf(arduinoCom)
            SPIF.Command = '';

        case 'START'
            FileName = SPIF.FileName;
            PathName = SPIF.PathName; 
            disp('Converting G code to coordinates')
            Coordinates = GetCAM(FileName,PathName);
            Theta = [];
            for i = 1:length(Coordinates)
                [theta1_new,theta2_new] = Get_theta1_theta2(Coordinates(i,2),Coordinates(i,3));
                Theta = [Theta;real(theta1_new),real(theta2_new)];
            end
            folder = 'C:\Users\HP\OneDrive - Universidade de Aveiro\Desktop\tese\Código\FicheiroTXT';
            Savetxt(folder,Theta);
            fwrite(arduinoCom,string(2))
            pause(2)
            fscanf(arduinoCom)
            SPIF.Command = '';
    end

    if SPIF.STOP == 1
        break
    end

    pause(0.5)
end
fclose(arduinoCom)



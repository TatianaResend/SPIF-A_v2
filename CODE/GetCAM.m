function [Coord] = GetCAM(FileName,PathName)
    % -----------------------------------------------------
    % Open .nc File
    % -----------------------------------------------------
    tic;
    
    STR=strcat(PathName,FileName);                  % String
    
    fid = fopen(STR,'r');
    File = textscan(fid,'%s','delimiter', '\n');
    fclose(fid);
    
    File = File{:};                                 % Convert CELL
    Size=size(File,1);
    
    % -----------------------------------------------------
    %Eliminate Headers - Until N1 is found  
    % -----------------------------------------------------
    for e1 = 1:Size
    
        a  = File(e1);
        
        if strfind(char(a), 'N111');
            break
        end
       
    end
    clear a;
    
    % -----------------------------------------------------
    % Eliminate Footers - After M30 is found  
    % -----------------------------------------------------
    for e2 = Size:-1:1
    
        a  = File(e2);
        
        if strfind(char(a), 'M30');
            break
        end
       
    end
    clear a;
    
    % -----------------------------------------------------
    % Extract Values
    % -----------------------------------------------------
    X = 0; Y = 0; Z = 25; I = 0; J = 0; K = 0;          % Coordinates
    gg = 0; M = 0;                                        % NC functions
    
    %Coord = zeros(e2-e1-1,7);
    
    Coord(1,:) = [0 0 25 0 0 0 0];
    
    for e=e1:1:e2-1
        
        a  = File(e);
    
        sp = strfind(a,' ');    sp = sp{:};                  % Find "Space"
    
        x   = strfind(a, 'X');   x = x{:};                     % Find "X"
    
        y   = strfind(a, 'Y');   y = y{:};                     % Find "Y"
    
        z   = strfind(a,'Z');     z = z{:};                     % Find "Z"
        
        i    = strfind(a,'I');      i = i{:};                      % Find "I"
        
        j    = strfind(a,'J');     j = j{:};                        % Find "J"
        
        k   = strfind(a,'K');   k = k{:};                      % Find "K"
        
        g1 = strfind(a,'G1 '); g1 = g1{:};                % Find "G1"
        
        g0 = strfind(a,'G0 '); g0 = g0{:};                % Find "G0"
    
        a = char(a);
        
        sp = [sp length(a)];
        
        if ~isempty(x)
            xp = find(sp>x); 
            X = a(x:sp(xp(1)));
            
            X = str2num(X(2:end));
        end
        
        if ~isempty(y)
            yp = find(sp>y); 
            Y = a(y:sp(yp(1)));
            
            Y = str2num(Y(2:end));
        end
        
        if ~isempty(z)
            zp = find(sp>z); 
            Z = a(z:sp(zp(1)));
            
            Z = str2num(Z(2:end));
        end
        
        if ~isempty(i)
            ip = find(sp>i); 
            I = a(i:sp(ip(1)));
            
            I = str2num(I(2:end));
        end
        
        if ~isempty(j)
            jp = find(sp>j); 
            J = a(j:sp(jp(1)));
            
            J = str2num(J(2:end));
        end
        
        if ~isempty(k)
            kp = find(sp>k); 
            K = a(k:sp(kp(1)));
            
            K = str2num(K(2:end));
        end
        
         if ~isempty(g1)
            gp1 = find(sp>g1); 
            gg = a(g1:sp(gp1(1)));
            
            gg = str2num(gg(2:end));
         end
        
         if ~isempty(g0)
            gp0 = find(sp>g0); 
            gg = a(g0:sp(gp0(1)));
            
            gg = str2num(gg(2:end));
         end
         
        Coord(e-e1+1,1) = X;
        Coord(e-e1+1,2) = Y;
        Coord(e-e1+1,3) = Z;
        
        Coord(e-e1+1,4) = I;
        Coord(e-e1+1,5) = J;
        Coord(e-e1+1,6) = K;
       
        Coord(e-e1+1,7) = gg;
    end
    
    Coord(end+1,:) = [0 0 25 0 0 0 0];
    Coord(end+1,:) = [0 0 25 0 0 0 0];
    disp(['Done. It took ' num2str(toc) ' seconds of processing']);
end




function Savetxt(folder,matrix)

% ---------------------------------------
% Check if you have any .txt files
% ---------------------------------------

% List all files in the folder
file_list = dir(folder);

% Check each file in the folder
for i = 1:length(file_list)
    % Get the file name
    file_name = file_list(i).name;
    
    % Check if the file is a .txt file
    if length(file_name)>2
        if strcmpi('.txt', file_name(end-3:end))
            % Delete the file
            delete(fullfile(folder, file_name));
        end
    end
end

% ---------------------------------------
% Save new .txt files
% ---------------------------------------
dlmwrite(folder+"\Angles.txt",matrix,',');

end
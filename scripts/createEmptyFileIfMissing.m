function createEmptyFileIfMissing(history_path)
%CREATEEMPTYFILEIFMISSING Prompt to create a file if it doesn't exist.
%   createEmptyFileIfMissing(history_path) checks if the file at 
%   history_path exists. If not, it asks the user to create it:
%       - Press Enter → creates an empty file (and folders if needed)
%       - Any other input → throws an error

    % Ensure input works with string or char
    history_path = char(history_path);

    % Get folder path
    folderPath = fileparts(history_path);

    if exist(history_path, 'file')
        return;  % file already exists, nothing to do
    end

    if ~exist(folderPath, 'dir')
        % Folder doesn't exist → ask for confirmation
        reply = input(sprintf('Folder(s) "%s" do not exist.\nPress Enter to create folder(s) and file, or any other key to cancel: ', strrep(folderPath,'\','\\')), 's');
        if isempty(reply)
            % Create folders
            mkdir(folderPath);
            % Create empty file
            fid = fopen(history_path, 'w');
            if fid == -1
                error('FileCreation:Failed', 'Cannot create file: %s', history_path);
            end
            fclose(fid);
            fprintf('Created folder(s) and empty file: %s\n', history_path);
        else
            error('FileCreation:Cancelled', 'File creation cancelled by user.');
        end
    else
        % Folder exists, just ask for file creation
        reply = input(sprintf('File "%s" does not exist.\nPress Enter to create it, or any other key to cancel: ', strrep(history_path,'\','\\')), 's');
        if isempty(reply)
            fid = fopen(history_path, 'w');
            if fid == -1
                error('FileCreation:Failed', 'Cannot create file: %s', history_path);
            end
            fclose(fid);
            fprintf('Created empty file: %s\n', history_path);
        else
            error('FileCreation:Cancelled', 'File creation cancelled by user.');
        end
    end
end

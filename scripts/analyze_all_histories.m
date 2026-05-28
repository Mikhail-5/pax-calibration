main();
function main()
% Define the folder pattern
folderPattern = 'C:\Projects\PAX_models\PAX_calibration\coefficients\*\history.md';

% Get a list of all matching files
files = dir(folderPattern);

% Preallocate cell array to store each file's content as a string array
fileContents = cell(1, numel(files));
IDs = cell(1, numel(files));

% Loop over each file and read lines as string arrays
for k = 1:numel(files)
    ID = extractAfter(files(k).folder,"C:\Projects\PAX_models\PAX_calibration\coefficients\");
    tmp = ID2MAC(ID);
    if(isempty(tmp))
        ID=ID+"!";
    else
        assert(ID==string(tmp));
    end
    ID = string(ID);

    fullPath = fullfile(files(k).folder, files(k).name);
    lines  = readlines(fullPath);
    lines = lines(strlength(lines)>0);
    % lines = ID+": "+lines;
    IDs{k} = string.empty(length(lines),0);
    IDs{k}(:,1) = ID;
    fileContents{k} = lines ;  % returns a string array
end

% Now combine all string arrays into one big string array
bigStringArray = vertcat(fileContents{:});
IDs = vertcat(IDs{:});

% Optional: display the combined array
% disp(bigStringArray);

%%
bigStringArray = bigStringArray(strlength(bigStringArray)>0);
clc;
[~,ii] = sort(bigStringArray);
bigStringArray=bigStringArray(ii);
IDs = IDs(ii);
disp(IDs+": "+bigStringArray)
end
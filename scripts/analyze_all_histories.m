main();
function main()
% Define the folder pattern
folderPattern = 'C:\Projects\pax-models\pax-calibration\coefficients\*\history.md';

% Get a list of all matching files
files = dir(folderPattern);

% Preallocate cell array to store each file's content as a string array
fileContents = cell(1, numel(files));
IDs = cell(1, numel(files));

% Loop over each file and read lines as string arrays
for k = 1:numel(files)
    ID = extractAfter(files(k).folder,"C:\Projects\pax-models\pax-calibration\coefficients\");
    tmp = ID2MAC(ID);
    if(isempty(tmp))
        ID=ID+"!";
    else
        assert(ID==string(tmp));
    end
    ID = string(ID);

    fullPath = fullfile(files(k).folder, files(k).name);
    lines  = readlines(fullPath);
    assert(lines(1)=="```")
    lines(1)="";
    lines = lines(strlength(lines)>0);
    clc;
    disp(lines)
    assert(issorted(extractBefore(lines,23)),"History is not sorted: "+ID)
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
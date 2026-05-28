clc; clear all; %#ok<CLALL>
assert(pwd == canonicalPath('.'),"Change directory to the script location")
coefFolder = canonicalPath('..\coefficients');

IDs = [
    "PDX1-L000045"
    "PDX1-L000046"
    "PDX1-L000047"
    "PDX1-L000311"
    "PDX1-L000317"
    "PDX1-L000321"
    "PDX1-R000011"
    "PDX1-R000015"
    "PDX1-R000302"
    "PDX1-R000305"
    "PDX1-R000308"
    "PDX1-R000310"
    "PDX1-R000315"
    "PDX1-R000316"
    ];
for ID = IDs'
    disp(ID)
    history_path= coefFolder+"\"+ID+"\history.md";
    createEmptyFileIfMissing(history_path);
    history_path_lines = readlines(history_path);
    string_to_add = datetime('now');
    string_to_add = datetime(string_to_add,'Format','yyyy-MM-dd''T''HH:mm:ss.SSS');
    string_to_add = (sprintf('%s - INFO - ',string_to_add));
    s = "Firmware was updated to version '01.01.00/01/001856'. Event predates this log entry.";
    assert(all(~contains(history_path_lines,s)));
    writelines(string_to_add+s, history_path, WriteMode="append")
    s = "Firmware version '01.01.00/01/001856' fell into fail-safe. Event predates this log entry.";
    assert(all(~contains(history_path_lines,s)));
    writelines(string_to_add+s, history_path, WriteMode="append")
end

% Failed to fail-safe:
% PDX1-L000045
% PDX1-L000046
% PDX1-L000047
% PDX1-L000311  preaged
% PDX1-L000317
% PDX1-L000321
% PDX1-R000011
% PDX1-R000015
% PDX1-R000302 preaged
% PDX1-R000305
% PDX1-R000308
% PDX1-R000310 preaged
% PDX1-R000315 preaged
% PDX1-R000316 preaged



%%
%%
return;0;
%%


for ID = IDs'
    history_path= coefFolder+"\"+ID+"\history.md";
    system('""C:\Programs\Notepad++\notepad++.exe"" "' + history_path+ '"');
end
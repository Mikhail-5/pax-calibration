clc; clear all; %#ok<CLALL>
assert(pwd == canonicalPath('.'),"Change directory to the script location")
coefFolder = canonicalPath('..\coefficients');

filenames = [
    "C:\Projects\PAX_Drift_Testbench\python\logs\meas_handshake_2026-03-09_17-10-00.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\meas_handshake_2026-03-09_17-02-32.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\meas_handshake_2026-03-09_17-01-17.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\meas_handshake_2026-03-09_17-19-03.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\meas_handshake_2026-03-09_17-15-29.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\meas_handshake_2026-03-09_17-12-40.log"
    ]';
IDs=string.empty;
MACs=string.empty;
SNs=string.empty;

% Read file
for filename = filenames
lines = readlines(filename);
expected_first_line_content = "- DEBUG - Logging started.";
assert(contains(lines(1),expected_first_line_content));
string_to_add = extractBefore(lines(1),expected_first_line_content);



% Join to single string (optional but convenient)
txt = strjoin(lines,newline);

% Extract values using regexp
ID_reg  = regexp(txt,'Axle ID:\s*([A-Z0-9\-]+)','tokens','once');
MAC_reg = regexp(txt,'\[([0-9A-F:]{17})\]','tokens','once');
SN_reg  = regexp(txt,'Serial:\s*(\d+)','tokens','once');

% Convert from token cells
[ID, MAC, SN] = ID2MAC(ID_reg{1});
ID=string(ID);
MAC=string(MAC);
SN=string(SN);

assert(ID == ID_reg{1});
assert(MAC == MAC_reg{1});
assert(SN  == SN_reg{1});

IDs(filename == filenames)=ID;
MACs(filename == filenames)=MAC;
SNs(filename == filenames)=SN;


hist_s = AxleCalibrator.read_history(ID);
assert(all(~contains(hist_s,string_to_add)));
string_to_add=string_to_add+"- INFO - "+"Handshake was performed.";
disp(string_to_add);
AxleCalibrator.add2history(ID, string_to_add);

end




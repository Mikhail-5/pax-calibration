clc; clear all;
IDs = [
"PDX1-R000320"
"PDX1-L000340"
]';
for ID = IDs
    % AxleCalibrator.read_history(ID)
    % assert(all(~contains(AxleCalibrator.read_history(ID),"Preaging")));
    % str_final = "2026-03-16T12:00:00.000 - INFO - Preaging was performed. No logfile. Event predates this log entry.";
    str_final = "2026-03-12T12:00:00.000 - INFO - The axle was programmed by special firmware version and was handed over to SiSy";
    AxleCalibrator.add2history(ID,str_final);
end

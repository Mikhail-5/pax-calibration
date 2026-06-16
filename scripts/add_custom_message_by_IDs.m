clc; clear all;
% "PDX1-R000320"
% "PDX1-L000340"
% "PDX1-L001610"
% str_final = "2026-03-16T12:00:00.000 - INFO - Preaging was performed. No logfile. Event predates this log entry.";
% str_final = "2026-03-12T12:00:00.000 - INFO - The axle was programmed by special firmware version and was handed over to SiSy";
% str_final = "2026-06-08T12:00:00.000 - INFO - Battery failed. Weak red LED light on startup, current consumption: 7 mA";
% str_final = "2026-06-08T12:00:00.000 - INFO - EEPROM failed";
% Event predates this log entry.
% "PDX1-L000308: 2026-05-09T16:49:26.981 - INFO - HBYA mailfunction was discovered during temperature compensation - "meas_parallel.py_2026-05-09_16-49-26.log"."

values = [
% "PDX1-R001645" "HB mailfunction was discovered during temperature compensation. HBYI = -Inf, HBXI fluctuates" "now"
% "PDX1-R001637" "Preaging was performed but not recorded due to improper installation. ""preaging.py_2026-06-10_21-46-34.log"""                     "2026-06-10T21:46:34.865"
% "PDX1-R001637" "Temperature compensation was not recorded due to improper installation. ""temperature.py_2026-06-12_17-18-31.log"""  "2026-06-12T17:18:32.451"
"PDX1-R001727" "Mikhail took it to Chemnitz" "now"
"PDX1-L001641" "Mikhail took it to Chemnitz" "now"
];
IDs = values(:,1)';
messages = values(:,2)';
times = values(:,3)';
dt = datetime('now');
dt.Format = 'yyyy-MM-dd''T''HH:mm:ss.SSS';
now_str = string(dt);
for i = 1:length(IDs)
    ID = IDs(i);
    message = messages(i);
    time = times(i);
    % AxleCalibrator.read_history(ID)
    % assert(all(~contains(AxleCalibrator.read_history(ID),"Preaging")));
    % str_final = "2026-03-16T12:00:00.000 - INFO - Preaging was performed. No logfile. Event predates this log entry.";
    % str_final = "2026-03-12T12:00:00.000 - INFO - The axle was programmed by special firmware version and was handed over to SiSy";
    % str_final = "2026-06-08T12:00:00.000 - INFO - Battery failed. Weak red LED light on startup, current consumption: 7 mA";
    if(isequal(time,"now"))
        str_final = now_str;
    elseif(class(time)=="string" && strlength(time)==23 && extractBetween(time,11,11)=="T")
        % "2026-06-10T21:46:34.865"
        str_final = time;
    else
        error(time)
    end
    str_final = str_final + " - INFO - ";
    str_final = str_final + message;
    % disp(str_final)
    history = AxleCalibrator.read_history(ID); 
    assert(all(~contains(history, message)))
    disp(str_final)
    AxleCalibrator.add2history(ID,str_final);
end

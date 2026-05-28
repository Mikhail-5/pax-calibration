clc; clear all; %#ok<CLALL>
assert(pwd == canonicalPath('.'),"Change directory to the script location")
coefFolder = canonicalPath('..\coefficients');

filenames = [
    % "C:\Projects\PAX_Drift_Testbench\python\logs\meas_handshake_2026-03-09_17-10-00.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\meas_handshake_2026-03-09_17-02-32.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\meas_handshake_2026-03-09_17-01-17.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\meas_handshake_2026-03-09_17-19-03.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\meas_handshake_2026-03-09_17-15-29.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\meas_handshake_2026-03-09_17-12-40.log"
    %%
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000304_2025-11-02_23-49-38.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000305_2025-11-02_23-30-20.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000311_2025-11-02_23-36-10.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000314_2025-11-02_23-44-49.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000010_2025-11-02_21-46-36.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000011_2025-11-02_22-21-28.log"
    % was added manually "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000013_2025-11-02_23-17-44.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000014_2025-11-02_22-46-05.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000015_2025-11-02_18-47-28.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000016_2025-11-02_21-59-20.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000231_2025-11-02_22-05-18.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000301_2025-11-02_18-56-57.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000302_2025-11-02_21-53-16.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000306_2025-11-02_22-25-36.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000307_2025-11-02_22-18-00.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000310_2025-11-02_22-58-43.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000313_2025-11-02_22-33-28.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000314_2025-11-02_22-29-04.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000303_2025-11-02_22-54-06.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000322_2025-11-02_18-52-19.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000323_2025-11-02_18-33-55.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000327_2025-11-02_21-50-08.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000328_2025-11-02_18-36-53.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000330_2025-11-02_18-39-53.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000332_2025-11-02_22-42-34.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000333_2025-11-02_22-39-26.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000336_2025-11-02_22-15-06.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000337_2025-11-02_22-36-23.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000339_2025-11-02_21-56-21.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000340_2025-11-02_22-08-36.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000342_2025-11-02_22-11-59.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000344_2025-11-02_23-12-25.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000347_2025-11-02_23-03-50.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000348_2025-11-02_23-06-59.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000349_2025-11-02_22-02-20.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000017_2025-11-02_18-24-22.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000304_2025-11-02_18-30-49.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000305_2025-11-02_18-11-49.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000341_2025-11-02_18-18-23.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000308_2025-11-02_17-56-17.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000048_2025-11-02_23-52-39.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000302_2025-11-02_23-55-47.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000303_2025-11-02_23-39-01.log"
    % % % ---------------------
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000043_2025-11-03_22-14-13.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000044_2025-11-03_22-41-12.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000045_2025-11-03_19-23-44.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000046_2025-11-03_22-20-32.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000047_2025-11-03_19-30-43.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000049_2025-11-03_19-47-57.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000307_2025-11-03_22-30-57.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000309_2025-11-03_23-07-22.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000310_2025-11-03_22-27-45.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000312_2025-11-03_19-44-01.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000313_2025-11-03_22-51-39.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000315_2025-11-03_19-34-55.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000316_2025-11-03_22-44-53.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000322_2025-11-03_23-01-18.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000323_2025-11-03_23-04-21.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000330_2025-11-03_18-56-07.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000334_2025-11-03_22-48-04.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000335_2025-11-03_22-24-00.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000336_2025-11-03_22-17-27.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000340_2025-11-03_23-10-11.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000344_2025-11-03_19-00-25.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000351_2025-11-03_22-58-01.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000321_2025-11-03_18-52-54.log"
    % retest of failures:
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000049_2025-11-04_12-36-14.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000315_2025-11-04_12-43-48.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000335_2025-11-04_12-32-56.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000336_2025-11-04_12-40-05.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000339_2025-11-04_12-17-07.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000340_2025-11-04_12-21-21.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000341_2025-11-04_12-24-59.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000344_2025-11-04_12-08-50.log"
    % % Handshakes:
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000317_2025-11-04_15-36-39.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000321_2025-11-04_15-39-19.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000325_2025-11-04_15-43-37.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000326_2025-11-04_15-40-08.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000329_2025-11-04_15-38-53.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000341_2025-11-04_15-38-07.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000342_2025-11-04_15-43-10.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000343_2025-11-04_15-40-38.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000346_2025-11-04_15-37-38.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000348_2025-11-04_15-36-03.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000350_2025-11-04_15-37-09.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000309_2025-11-04_15-47-15.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000311_2025-11-04_15-41-53.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000312_2025-11-04_15-44-57.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000315_2025-11-04_15-45-31.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000317_2025-11-04_15-42-15.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000318_2025-11-04_15-46-04.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000320_2025-11-04_15-42-47.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000324_2025-11-04_15-41-02.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000325_2025-11-04_15-44-05.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000329_2025-11-04_15-46-45.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000335_2025-11-04_15-41-24.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000343_2025-11-04_15-44-32.log"
    % --------------
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000318_2025-11-04_18-14-41.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000320_2025-11-04_18-34-15.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000324_2025-11-04_18-31-46.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000325_2025-11-04_18-37-17.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000329_2025-11-04_18-20-52.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000335_2025-11-04_18-10-32.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000343_2025-11-04_18-26-49.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000325_2025-11-04_17-31-23.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000036_2025-11-04_19-10-07.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000317_2025-11-04_17-44-40.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000317_2025-11-04_19-30-44.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000319_2025-11-04_19-05-01.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000321_2025-11-04_17-54-21.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000326_2025-11-04_18-04-41.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000329_2025-11-04_18-01-53.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000337_2025-11-04_18-58-52.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000339_2025-11-04_19-34-34.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000341_2025-11-04_17-50-43.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000342_2025-11-04_18-55-44.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000346_2025-11-04_17-47-55.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000348_2025-11-04_17-36-41.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000350_2025-11-04_17-41-26.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000311_2025-11-04_18-07-25.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000312_2025-11-04_18-23-41.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000012_2025-11-04_22-08-05.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000326_2025-11-04_19-24-06.log"
    %% one uknown (L000318_2025) and 4 remeasures
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000318_2025-11-04_17-25-06.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000315_2025-11-05_12-18-25.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000309_2025-11-05_12-12-06.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000349_2025-11-05_12-21-16.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000343_2025-11-05_12-15-31.log"
    %% L000042 - pins repaired, HBYA failure according to Andreas. HBYA=+inf verified
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000042_2025-11-05_13-29-55.log"
    %% repaired by Hagen - all passed
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000316_2025-11-07_13-29-49.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000308_2025-11-07_13-33-12.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000327_2025-11-07_13-45-37.log" % failed firmware? blinking red
    % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000328_2025-11-07_13-36-21.log" % failed firmware? blinking red
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000345_2025-11-07_13-42-06.log"
    %% glued, O-ring installed
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000048_2025-11-18_17-27-12.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000310_2025-11-18_17-30-00.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000012_2025-11-18_17-18-39.log"
    % was added manually  "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000013_2025-11-18_17-21-27.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000017_2025-11-18_17-24-14.log"
    ]';


IDs=string.empty;
MACs=string.empty;
SNs=string.empty;

% Read file
for filename = filenames
    lines = readlines(filename);
    assert(contains(lines(1),"Started new period log file: C:\Saxonar\SharedWithMikhail\DriftStandLogs\SN_PDX"))
    ID = extractAfter(lines(1),"Started new period log file: C:\Saxonar\SharedWithMikhail\DriftStandLogs\SN_");
    ID = extractBefore(ID,"_");
    assert(ID==ID2MAC(ID));
    string_to_add = extractBefore(lines(1),"Started new period log file: C:\Saxonar\SharedWithMikhail\DriftStandLogs\SN_");
    hist_s = AxleCalibrator.read_history(ID);
    assert(all(~contains(hist_s,string_to_add)));
    % if(~isempty(hist_s)&&any(contains(hist_s,"rift")))
    %     disp(hist_s)
    % end
    [failedIDs, failures, passedIDs] = zeroSeriesResults();
    if(any(ID==passedIDs))
        string_to_add=string_to_add+"Drift test was performed. Success.";
    else
        string_to_add=string_to_add+"Drift test was performed. Failed: "+failures(failedIDs==ID);
    end
    disp(string_to_add);
    AxleCalibrator.add2history(ID, string_to_add);
end
return
% Extract ID and datetime parts
tokens = regexp(filenames_from_prev_drift_meas(), ...
    'SN_(PDX1-[LR]\d+)_(\d{4}-\d{2}-\d{2})_(\d{2}-\d{2}-\d{2})', ...
    'tokens','once');

tokens = vertcat(tokens{:});

ID = tokens(:,1);

% Build datetime
dt = datetime(tokens(:,2) + " " + replace(tokens(:,3),"-",":"), ...
    'InputFormat','yyyy-MM-dd HH:mm:ss');

% Convert to desired string format
timeStr = string(dt,'yyyy-MM-dd''T''HH:mm:ss.SSS');


function filenames = filenames_from_prev_drift_meas()
filenames =[
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000304_2025-11-02_23-49-38.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000305_2025-11-02_23-30-20.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000311_2025-11-02_23-36-10.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000314_2025-11-02_23-44-49.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000010_2025-11-02_21-46-36.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000011_2025-11-02_22-21-28.log"
    % was added manually "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000013_2025-11-02_23-17-44.log"
    
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000014_2025-11-02_22-46-05.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000015_2025-11-02_18-47-28.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000016_2025-11-02_21-59-20.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000231_2025-11-02_22-05-18.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000301_2025-11-02_18-56-57.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000302_2025-11-02_21-53-16.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000306_2025-11-02_22-25-36.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000307_2025-11-02_22-18-00.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000310_2025-11-02_22-58-43.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000313_2025-11-02_22-33-28.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000314_2025-11-02_22-29-04.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000303_2025-11-02_22-54-06.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000322_2025-11-02_18-52-19.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000323_2025-11-02_18-33-55.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000327_2025-11-02_21-50-08.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000328_2025-11-02_18-36-53.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000330_2025-11-02_18-39-53.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000332_2025-11-02_22-42-34.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000333_2025-11-02_22-39-26.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000336_2025-11-02_22-15-06.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000337_2025-11-02_22-36-23.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000339_2025-11-02_21-56-21.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000340_2025-11-02_22-08-36.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000342_2025-11-02_22-11-59.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000344_2025-11-02_23-12-25.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000347_2025-11-02_23-03-50.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000348_2025-11-02_23-06-59.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000349_2025-11-02_22-02-20.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000017_2025-11-02_18-24-22.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000304_2025-11-02_18-30-49.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000305_2025-11-02_18-11-49.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000341_2025-11-02_18-18-23.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000308_2025-11-02_17-56-17.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000048_2025-11-02_23-52-39.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000302_2025-11-02_23-55-47.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000303_2025-11-02_23-39-01.log"
    % % % ---------------------
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000043_2025-11-03_22-14-13.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000044_2025-11-03_22-41-12.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000045_2025-11-03_19-23-44.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000046_2025-11-03_22-20-32.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000047_2025-11-03_19-30-43.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000049_2025-11-03_19-47-57.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000307_2025-11-03_22-30-57.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000309_2025-11-03_23-07-22.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000310_2025-11-03_22-27-45.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000312_2025-11-03_19-44-01.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000313_2025-11-03_22-51-39.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000315_2025-11-03_19-34-55.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000316_2025-11-03_22-44-53.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000322_2025-11-03_23-01-18.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000323_2025-11-03_23-04-21.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000330_2025-11-03_18-56-07.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000334_2025-11-03_22-48-04.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000335_2025-11-03_22-24-00.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000336_2025-11-03_22-17-27.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000340_2025-11-03_23-10-11.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000344_2025-11-03_19-00-25.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000351_2025-11-03_22-58-01.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000321_2025-11-03_18-52-54.log"
    % retest of failures:
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000049_2025-11-04_12-36-14.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000315_2025-11-04_12-43-48.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000335_2025-11-04_12-32-56.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000336_2025-11-04_12-40-05.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000339_2025-11-04_12-17-07.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000340_2025-11-04_12-21-21.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000341_2025-11-04_12-24-59.log"
    % % % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000344_2025-11-04_12-08-50.log"
    % % Handshakes:
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000317_2025-11-04_15-36-39.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000321_2025-11-04_15-39-19.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000325_2025-11-04_15-43-37.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000326_2025-11-04_15-40-08.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000329_2025-11-04_15-38-53.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000341_2025-11-04_15-38-07.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000342_2025-11-04_15-43-10.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000343_2025-11-04_15-40-38.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000346_2025-11-04_15-37-38.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000348_2025-11-04_15-36-03.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-L000350_2025-11-04_15-37-09.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000309_2025-11-04_15-47-15.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000311_2025-11-04_15-41-53.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000312_2025-11-04_15-44-57.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000315_2025-11-04_15-45-31.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000317_2025-11-04_15-42-15.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000318_2025-11-04_15-46-04.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000320_2025-11-04_15-42-47.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000324_2025-11-04_15-41-02.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000325_2025-11-04_15-44-05.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000329_2025-11-04_15-46-45.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000335_2025-11-04_15-41-24.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\handshakes\SN_PDX1-R000343_2025-11-04_15-44-32.log"
    % --------------
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000318_2025-11-04_18-14-41.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000320_2025-11-04_18-34-15.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000324_2025-11-04_18-31-46.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000325_2025-11-04_18-37-17.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000329_2025-11-04_18-20-52.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000335_2025-11-04_18-10-32.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000343_2025-11-04_18-26-49.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000325_2025-11-04_17-31-23.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000036_2025-11-04_19-10-07.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000317_2025-11-04_17-44-40.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000317_2025-11-04_19-30-44.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000319_2025-11-04_19-05-01.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000321_2025-11-04_17-54-21.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000326_2025-11-04_18-04-41.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000329_2025-11-04_18-01-53.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000337_2025-11-04_18-58-52.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000339_2025-11-04_19-34-34.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000341_2025-11-04_17-50-43.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000342_2025-11-04_18-55-44.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000346_2025-11-04_17-47-55.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000348_2025-11-04_17-36-41.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000350_2025-11-04_17-41-26.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000311_2025-11-04_18-07-25.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000312_2025-11-04_18-23-41.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000012_2025-11-04_22-08-05.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000326_2025-11-04_19-24-06.log"
    %% one uknown (L000318_2025) and 4 remeasures
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000318_2025-11-04_17-25-06.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000315_2025-11-05_12-18-25.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000309_2025-11-05_12-12-06.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000349_2025-11-05_12-21-16.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000343_2025-11-05_12-15-31.log"
    %% L000042 - pins repaired, HBYA failure according to Andreas. HBYA=+inf verified
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000042_2025-11-05_13-29-55.log"
    %% repaired by Hagen - all passed
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000316_2025-11-07_13-29-49.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000308_2025-11-07_13-33-12.log"
    % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000327_2025-11-07_13-45-37.log" % failed firmware? blinking red
    % "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000328_2025-11-07_13-36-21.log" % failed firmware? blinking red
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000345_2025-11-07_13-42-06.log"
    %% glued, O-ring installed
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000048_2025-11-18_17-27-12.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-L000310_2025-11-18_17-30-00.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000012_2025-11-18_17-18-39.log"
    % was added manually"C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000013_2025-11-18_17-21-27.log"
    "C:\Projects\PAX_Drift_Testbench\python\logs\SN_PDX1-R000017_2025-11-18_17-24-14.log"
    ];
end
function [failedIDs, failures, passedIDs] = zeroSeriesResults()
data = [
    "PDX1-L000327","failed firmware? blinking red";
    "PDX1-L000328","failed firmware? blinking red";
    "PDX1-L000335","HBYA problem – failed bonding?";
    "PDX1-L000049","HBYI = -inf";
    "PDX1-L000315","HBYI = -inf";
    "PDX1-R000319","HBYI = -inf";
    "PDX1-R000339","HBYI = +inf";
    "PDX1-L000336","HBYA = -inf";
    "PDX1-L000042","HBYA = +inf";
    "PDX1-R000341","HBYA = +inf";
    "PDX1-R000344","HBXA = -inf";
    "PDX1-L000341","HBXA&HBXI&HBYA&HBYI = +inf";
    "PDX1-R000340","HBXI - HBYI shortcut";
    ];
failedIDs = data(:,1);
failures = data(:,2);
passedIDs = [
"PDX1-L000036"
"PDX1-L000043"
"PDX1-L000044"
"PDX1-L000045"
"PDX1-L000046"
"PDX1-L000047"
"PDX1-L000048"
"PDX1-L000302"
"PDX1-L000303"
"PDX1-L000304"
"PDX1-L000305"
"PDX1-L000307"
"PDX1-L000308"
"PDX1-L000309"
"PDX1-L000310"
"PDX1-L000311"
"PDX1-L000312"
"PDX1-L000313"
"PDX1-L000314"
"PDX1-L000316"
"PDX1-L000317"
"PDX1-L000318"
"PDX1-L000321"
"PDX1-L000322"
"PDX1-L000323"
"PDX1-L000325"
"PDX1-L000326"
"PDX1-L000329"
"PDX1-L000330"
"PDX1-L000334"
"PDX1-L000337"
"PDX1-L000339"
"PDX1-L000340"
"PDX1-L000342"
"PDX1-L000343"
"PDX1-L000344"
"PDX1-L000345"
"PDX1-L000346"
"PDX1-L000348"
"PDX1-L000349"
"PDX1-L000350"
"PDX1-L000351"
"PDX1-R000010"
"PDX1-R000011"
"PDX1-R000012"
"PDX1-R000013"
"PDX1-R000014"
"PDX1-R000015"
"PDX1-R000016"
"PDX1-R000017"
"PDX1-R000231"
"PDX1-R000301"
"PDX1-R000302"
"PDX1-R000303"
"PDX1-R000304"
"PDX1-R000305"
"PDX1-R000306"
"PDX1-R000307"
"PDX1-R000308"
"PDX1-R000309"
"PDX1-R000310"
"PDX1-R000311"
"PDX1-R000312"
"PDX1-R000313"
"PDX1-R000314"
"PDX1-R000315"
"PDX1-R000316"
"PDX1-R000317"
"PDX1-R000318"
"PDX1-R000320"
"PDX1-R000321"
"PDX1-R000322"
"PDX1-R000323"
"PDX1-R000324"
"PDX1-R000325"
"PDX1-R000326"
"PDX1-R000327"
"PDX1-R000328"
"PDX1-R000329"
"PDX1-R000330"
"PDX1-R000332"
"PDX1-R000333"
"PDX1-R000335"
"PDX1-R000336"
"PDX1-R000337"
"PDX1-R000342"
"PDX1-R000343"
"PDX1-R000347"
"PDX1-R000348"
"PDX1-R000349" 
];
end
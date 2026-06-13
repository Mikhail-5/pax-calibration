clc; clear all; %#ok<CLALL>
assert(pwd == canonicalPath('.'),"Change directory to the script location")
coefFolder = canonicalPath('..\coefficients');
filename = [
% "C:\Projects\PAX_calib_data\data\cube.py_2026-06-09_21-19-06.log"
% "C:\Projects\PAX_calib_data\data\cube.py_2026-06-09_22-25-15.log"
% "C:\Projects\PAX_calib_data\data\cube.py_2026-06-09_22-13-56.log"
% "C:\Projects\PAX_calib_data\data\cube.py_2026-06-09_22-04-10.log"
% "C:\Projects\PAX_calib_data\data\cube.py_2026-06-09_21-54-47.log"
% "C:\Projects\PAX_calib_data\data\cube.py_2026-06-09_21-45-38.log"
% "C:\Projects\PAX_calib_data\data\cube.py_2026-06-09_21-36-13.log"
    ]; %#ok<NBRAK2>
add_log2_internal(filename)

function add_log2_internal(filename)
[~, name, ext] = fileparts(filename);
fname_with_ext = name + ext;

reader = AxleLogReader(filename);
% a.force_text_parsing = true;
%  a.save_mat = false;
reader.increasingSegmentIndexes = AxleLogReader.increasingSegmentIndexes_skip;
reader.firmware_version_support ="2";
reader.setup_CMD="1+";
reader.read(true);
%%
IDs = string.empty();
MACs = IDs;
SNs = IDs;
history_paths = IDs;
for axle_i = 1:length(reader.data)
    [IDs(axle_i,1), MACs(axle_i,1), SNs(axle_i,1)] = ID2MAC([],reader.data{axle_i}.Props.MAC_Address);
    assert(SNs(axle_i)==reader.data{axle_i}.Props.UUT_SN,"Unexpected SN " +SNs(axle_i)+" for "+IDs(axle_i))
    coef_dir = coefFolder+"\"+IDs(axle_i);
    history_paths(axle_i) = coefFolder+"\"+IDs(axle_i)+"\history.md";
    createEmptyFileIfMissing(history_paths(axle_i));
end
%%
fid = fopen(filename, 'r');
string_to_add = fread(fid, 2000, '*char')';
fclose(fid);
string_to_add = string(split(string_to_add,newline));
string_to_add = string_to_add(contains(string_to_add," - INFO - Started with filename: "));
string_to_add = extractBefore(string_to_add,34);
task = fname_with_ext;
switch fname_with_ext
    % legacy
    case "rotplateVert25Hz_.py_2026-02-10_11-56-12.log"
    case "rotplateVert100Hz_2026-02-10_11-33-47.log"
    case "rotplateHor100Hz_2026-02-10_10-42-51.log"
    case "rotplateHor25Hz_2026-02-10_10-21-17.log"
    case "cubeCalib_L322R016_2026-02-10_17-24-17.log"
    case "meas_parallel.py_2026-02-11_14-36-52.log"
    case "meas_parallel.py_2026-03-01_17-08-38.log"
    case "cube_calib_2026-03-01_18-09-26.log"
    case "meas_parallel.py_2026-03-05_19-35-04.log"
    case "indoor_cycling30min_and_8h_rest_2026-03-08_22-33-33.log"
    case {"thermal_calib_2026-02-09_11-21-43.log", "meas_parallel.py_2026-03-12_09-05-02.log", "meas_parallel.py_2026-03-15_21-56-56.log", "meas_parallel.py_2026-03-20_11-04-52.log", "meas_parallel.py_2026-05-09_16-49-26.log"}
        task = "thermal_calib";
    case {"meas_parallel.py_2026-03-12_19-39-08.log", "meas_parallel.py_2026-03-12_19-43-45.log"}
    case {"meas_parallel.py_2026-03-14_17-59-48.log", "meas_parallel.py_2026-03-16_15-02-48.log"}
    case {"meas_parallel.py_2026-05-10_16-32-59.log", "meas_parallel.py_2026-05-09_12-37-03.log", "meas_parallel.py_2026-05-09_12-25-35.log"}
    case {"meas_parallel.py_2026-05-09_12-50-23.log", "meas_parallel.py_2026-03-09_12-34-54.log", "meas_parallel.py_2026-03-14_17-49-22.log", "meas_parallel.py_2026-03-16_14-55-24.log"}
        task = "cube_calib";
    case {"meas_axles_and_GSV.py_2026-03-10_19-33-29.log", "meas_axles_and_GSV.py_2026-03-13_17-30-09.log", "meas_axles_and_GSV.py_2026-03-14_18-42-09.log", "meas_axles_and_GSV.py_2026-03-16_21-51-46.log", "meas_axles_and_GSV.py_2026-03-16_22-44-16.log",...
            "meas_axles_and_GSV.py_2026-03-19_11-02-34.log", "meas_axles_and_GSV.py_2026-03-21_10-53-59.log", "meas_axles_and_GSV.py_2026-03-21_11-37-43.log" "meas_axles_and_GSV.py_2026-05-09_14-59-14.log", "force_calib_combined_2026-05-09_16-26-47.log"}
        task = "force_calib";
    case {"meas_parallel.py_2026-03-09_19-25-51.log" ,"meas_parallel.py_2026-03-13_12-23-57.log","meas_parallel.py_2026-05-23_22-58-42.log"}
        task = "preaging";
    case "indoor_2pedals_Chemnitz__2026-04-05_21-31-02.log"
    otherwise
        task = "unknown"
end


switch task
    % case "rotplateVert25Hz_.py_2026-02-10_11-56-12.log"
    %     for axle_i = 1:length(reader.data)
    %         lines = readlines(history_paths(axle_i));
    %         assert(all(~contains(lines,"Rotating plate calibration was performed.")),"Duplicated string?");
    %         ID = IDs(axle_i);
    %         s =  @empty;
    %         switch ID
    %             case "PDX1-L000322"; s="alpha_plate=180°, l_crankarm = 0.20";
    %             case "PDX1-L000306"; s="alpha_plate=180°, l_crankarm = 0.15";
    %             case "PDX1-R000016"; s="alpha_plate=  0°, l_crankarm = 0.20";
    %             otherwise; error("Unexpected ID: "+ID);
    %         end
    %         writelines(string_to_add+"Rotating plate calibration was performed. "+s+", "+'"'+fname_with_ext+'"', history_paths(axle_i), WriteMode="append")
    %     end
    % case "rotplateVert100Hz_2026-02-10_11-33-47.log"
    %     for axle_i = 1:length(reader.data)
    %         lines = readlines(history_paths(axle_i));
    %         % assert(all(~contains(lines,"Rotating plate calibration was performed.")),"Duplicated string?");
    %         assert(all(~contains(lines,fname_with_ext)),"Duplicated string?");
    %         ID = IDs(axle_i);
    %         s =  @empty;
    %         switch ID
    %             case "PDX1-L000322"; s="alpha_plate=180°, l_crankarm = 0.20";
    %             case "PDX1-L000306"; s="alpha_plate=180°, l_crankarm = 0.15";
    %             case "PDX1-R000016"; s="alpha_plate=  0°, l_crankarm = 0.20";
    %             otherwise; error("Unexpected ID: "+ID);
    %         end
    %         writelines(string_to_add+"Rotating plate calibration was performed. "+s+", "+'"'+fname_with_ext+'"', history_paths(axle_i), WriteMode="append")
    %     end
    % case "rotplateHor100Hz_2026-02-10_10-42-51.log"
    %     for axle_i = 1:length(reader.data)
    %         lines = readlines(history_paths(axle_i));
    %         % assert(all(~contains(lines,"Rotating plate calibration was performed.")),"Duplicated string?");
    %         assert(all(~contains(lines,fname_with_ext)),"Duplicated string?");
    %         ID = IDs(axle_i);
    %         s =  @empty;
    %         switch ID
    %             case "PDX1-L000322"; s="alpha_plate=180°, l_crankarm = 0.20";
    %             case "PDX1-L000306"; s="alpha_plate=180°, l_crankarm = 0.15";
    %             case "PDX1-R000017"; s="alpha_plate=  0°, l_crankarm = 0.15";
    %             case "PDX1-R000016"; s="alpha_plate=  0°, l_crankarm = 0.20";
    %             otherwise; error("Unexpected ID: "+ID);
    %         end
    %         writelines(string_to_add+"Rotating plate calibration was performed. "+s+", "+'"'+fname_with_ext+'"', history_paths(axle_i), WriteMode="append")
    %     end
    % case "rotplateHor25Hz_2026-02-10_10-21-17.log"
    %     for axle_i = 1:length(reader.data)
    %         lines = readlines(history_paths(axle_i));
    %         % assert(all(~contains(lines,"Rotating plate calibration was performed.")),"Duplicated string?");
    %         assert(all(~contains(lines,fname_with_ext)),"Duplicated string?");
    %         ID = IDs(axle_i);
    %         s =  @empty;
    %         switch ID
    %             case "PDX1-L000322"; s="alpha_plate=180°, l_crankarm = 0.20";
    %             case "PDX1-L000306"; s="alpha_plate=180°, l_crankarm = 0.15";
    %             case "PDX1-R000017"; s="alpha_plate=  0°, l_crankarm = 0.15";
    %             case "PDX1-R000016"; s="alpha_plate=  0°, l_crankarm = 0.20";
    %             otherwise; error("Unexpected ID: "+ID);
    %         end
    %         writelines(string_to_add+"Rotating plate calibration was performed. "+s+", "+'"'+fname_with_ext+'"', history_paths(axle_i), WriteMode="append")
    %     end
    % case "cubeCalib_L322R016_2026-02-10_17-24-17.log"
    %     for axle_i = 1:length(reader.data)
    %         lines = readlines(history_paths(axle_i));
    %         % assert(all(~contains(lines,"Rotating plate calibration was performed.")),"Duplicated string?");
    %         assert(all(~contains(lines,fname_with_ext)),"Duplicated string?");
    %         writelines(string_to_add+"Cube calibration was performed. "+'"'+fname_with_ext+'"', history_paths(axle_i), WriteMode="append")
    %     end
    % case "meas_parallel.py_2026-02-11_14-36-52.log"
    %     for axle_i = 1:length(reader.data)
    %         lines = readlines(history_paths(axle_i));
    %         % assert(all(~contains(lines,"Rotating plate calibration was performed.")),"Duplicated string?");
    %         assert(all(~contains(lines,fname_with_ext)),"Duplicated string?");
    %         ID = IDs(axle_i);
    %         s =  @empty;
    %         switch ID
    %             case "PDX1-L000304"; s="alpha_plate=  0°, l_crankarm = 0.20";
    %             case "PDX1-L000306"; s="alpha_plate=  0°, l_crankarm = 0.15"; continue; % - failed meas
    %             case "PDX1-L000309"; s="alpha_plate=  0°, l_crankarm = 0.10";
    %             case "PDX1-R000013"; s="alpha_plate=180°, l_crankarm = 0.10";
    %             case "PDX1-R000017"; s="alpha_plate=180°, l_crankarm = 0.15";
    %             case "PDX1-R000231"; s="alpha_plate=180°, l_crankarm = 0.20";
    %             otherwise
    %                 error("Unexpected ID: "+ID+newline+'case "'+ID+'"; s="alpha_plate=  0°, l_crankarm = 0. 0";');
    %         end
    %         str_final = string_to_add+"Rotating plate calibration was performed. "+s+", "+'"'+fname_with_ext+'"';
    %         str_final = str_final+". Event predates this log entry.";
    %         writelines(str_final, history_paths(axle_i), WriteMode="append");
    %         disp(str_final)
    %     end
    % case "meas_parallel.py_2026-03-01_17-08-38.log"
    %     for axle_i = 1:length(reader.data)
    %         lines = readlines(history_paths(axle_i));
    %         % assert(all(~contains(lines,"Rotating plate calibration was performed.")),"Duplicated string?");
    %         assert(all(~contains(lines,fname_with_ext)),"Duplicated string?");
    %         ID = IDs(axle_i);
    %         s =  @empty;
    %         switch ID
    %             case "PDX1-L000304"; s="alpha_plate=  0°, l_crankarm = 0.20";
    %             case "PDX1-L000306"; s="alpha_plate= 60°, l_crankarm = 0.20"; continue; % - failed meas
    %             case "PDX1-L000309"; s="alpha_plate=120°, l_crankarm = 0.20";
    %             case "PDX1-R000013"; s="alpha_plate=180°, l_crankarm = 0.20";
    %             case "PDX1-R000017"; s="alpha_plate=240°, l_crankarm = 0.20";
    %             case "PDX1-R000231"; s="alpha_plate=300°, l_crankarm = 0.20";
    %             otherwise
    %                 error("Unexpected ID: "+ID+newline+'case "'+ID+'"; s="alpha_plate=  0°, l_crankarm = 0. 0";');
    %         end
    %         str_final = string_to_add+"Vertical rotation test was performed. "+s+", "+'"'+fname_with_ext+'"';
    %         % str_final = str_final+". Event predates this log entry.";
    %         writelines(str_final, history_paths(axle_i), WriteMode="append");
    %         disp(str_final)
    %     end
    % case "cube_calib_2026-03-01_18-09-26.log"
    %     for axle_i = 1:length(reader.data)
    %         lines = readlines(history_paths(axle_i));
    %         assert(all(~contains(lines,fname_with_ext)),"Duplicated string?");
    %         writelines(string_to_add+"Cube calibration was performed. "+'"'+fname_with_ext+'"', history_paths(axle_i), WriteMode="append")
    %     end
    % case "meas_parallel.py_2026-03-05_19-35-04.log"
    %     for axle_i = 1:length(reader.data)
    %         lines = readlines(history_paths(axle_i));
    %         assert(all(~contains(lines,fname_with_ext)),"Duplicated string?");
    %         writelines(string_to_add+"Force calibration was performed. Force sensor file - 05_03_26-18_38_18.tdms,  log file - "+'"'+fname_with_ext+'"', history_paths(axle_i), WriteMode="append")
    %     end
    % case "indoor_cycling30min_and_8h_rest_2026-03-08_22-33-33.log"
    %     for axle_i = 1:length(reader.data)
    %         lines = readlines(history_paths(axle_i));
    %         assert(all(~contains(lines,fname_with_ext)),"Duplicated string?");
    %         writelines(string_to_add+"A test was performed. 30 minutes indoor cycling and 8 hours wait. Fs = 100 Hz. "+'"'+fname_with_ext+'"', history_paths(axle_i), WriteMode="append")
    %     end
    case "thermal_calib"
        for axle_i = 1:length(reader.data)
            assert(all(~contains(AxleCalibrator.read_history(IDs(axle_i)),fname_with_ext)),"Duplicated string?");
            AxleCalibrator.add2history(IDs(axle_i),string_to_add+"Temperature compensation was performed. "+'"'+fname_with_ext+'"')
        end

    % case {"meas_parallel.py_2026-03-12_19-39-08.log", "meas_parallel.py_2026-03-12_19-43-45.log"}
    %     assert(isscalar(reader.data))
    %     axle_i=1;
    %     Fs = (reader.data{axle_i}.BMI.Props.ACC_ODR_Hz);
    %     assert(all(~contains(AxleCalibrator.read_history(IDs(axle_i)),fname_with_ext)),"Duplicated string?");
    %     AxleCalibrator.add2history(IDs(axle_i),string_to_add+"Quick test was performed. Some samples are stuck (are read from previous channel). Firmware 01.01.00/01/002211, Fs = "+string(Fs)+" [Hz]."+'"'+fname_with_ext+'"')
    % case {"meas_parallel.py_2026-03-14_17-59-48.log", "meas_parallel.py_2026-03-16_15-02-48.log"}
    %     for axle_i = 1:length(reader.data)
    %         assert(all(~contains(AxleCalibrator.read_history(IDs(axle_i)),fname_with_ext)),"Duplicated string?");
    %         ID = IDs(axle_i);
    %         s =  @empty;
    %         IDs_sorted = sort(IDs);
    %         switch ID
    %             case IDs_sorted(1); s="alpha_plate=  0°, l_crankarm = 0.20";
    %             case IDs_sorted(2); s="alpha_plate=  0°, l_crankarm = 0.15";
    %             case IDs_sorted(3); s="alpha_plate=  0°, l_crankarm = 0.10";
    %             case IDs_sorted(4); s="alpha_plate=180°, l_crankarm = 0.10";
    %             case IDs_sorted(5); s="alpha_plate=180°, l_crankarm = 0.15";
    %             case IDs_sorted(6); s="alpha_plate=180°, l_crankarm = 0.20";
    %             otherwise
    %                 error("Unexpected ID: "+ID+newline+'case "'+ID+'"; s="alpha_plate=  0°, l_crankarm = 0. 0";');
    %         end
    %         str_final = string_to_add+"Rotating plate calibration was performed. "+s+", "+'"'+fname_with_ext+'"';
    %         AxleCalibrator.add2history(IDs(axle_i),str_final)
    %         disp(str_final)
    %     end
    % case { "meas_parallel.py_2026-05-10_16-32-59.log", "meas_parallel.py_2026-05-09_12-37-03.log", "meas_parallel.py_2026-05-09_12-25-35.log"}
    %     for axle_i = 1:length(reader.data)
    %         assert(all(~contains(AxleCalibrator.read_history(IDs(axle_i)),fname_with_ext)),"Duplicated string?");
    %         ID = IDs(axle_i);
    %         s =  @empty;
    %         IDs_sorted = sort(IDs);
    %         switch ID
    %             case IDs_sorted(1); s="alpha_plate=  0°, l_crankarm = 0.20";
    %             case IDs_sorted(2); s="alpha_plate= 30°, l_crankarm = 0.20";
    %             case IDs_sorted(3); s="alpha_plate=180°, l_crankarm = 0.20";
    %             case IDs_sorted(4); s="alpha_plate=240°, l_crankarm = 0.20"; assert(length(IDs)==4)
    %             otherwise
    %                 error("Unexpected ID: "+ID+newline+'case "'+ID+'"; s="alpha_plate=  0°, l_crankarm = 0. 0";');
    %         end
    %         AxleCalibrator.add2history(IDs(axle_i),string_to_add+...
    %             "Rotating plate calibration was performed. "+s+", "+'"'+fname_with_ext+'"')
    %     end
    case "cube_calib"
        for axle_i = 1:length(reader.data)
            assert(all(~contains(AxleCalibrator.read_history(IDs(axle_i)),fname_with_ext)),"Duplicated string?");
            AxleCalibrator.add2history(IDs(axle_i),string_to_add+...
                "Cube calibration was performed. "+'"'+fname_with_ext+'"')
        end
    case "force_calib"
        assert(isscalar(reader.data))
        axle_i=1;
        assert(all(~contains(AxleCalibrator.read_history(IDs(axle_i)),fname_with_ext)),"Duplicated string?");
        AxleCalibrator.add2history(IDs(axle_i),string_to_add+...
            "Force calibration was performed. 3 PCOs, 3 levels. "+'"'+fname_with_ext+'"')
    case "preaging"
        for axle_i = 1:length(reader.data)
            assert(all(~contains(AxleCalibrator.read_history(IDs(axle_i)),fname_with_ext)),"Duplicated string?");
            AxleCalibrator.add2history(IDs(axle_i),string_to_add+...
                "Preaging was performed. "+'"'+fname_with_ext+'"')
        end
    % case "indoor_2pedals_Chemnitz__2026-04-05_21-31-02.log"
    %     for axle_i = 1:length(reader.data)
    %         assert(all(~contains(AxleCalibrator.read_history(IDs(axle_i)),fname_with_ext)),"Duplicated string?");
    %         AxleCalibrator.add2history(IDs(axle_i),string_to_add+...
    %             "A test was performed. 20 minutes indoor cycling. Chemnitz. Fs = 50 Hz. "+'"'+fname_with_ext+'"');
    %     end
    otherwise
        error("Unexpected fname_with_ext: "+newline+'    case "'+fname_with_ext+'"')
end

end
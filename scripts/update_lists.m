clc; clear all;
tableData = ID2MAC();
clc;
fid1 = fopen("../pedals_by_ID.md","w");
tableData = sortrows(tableData, "ID");

for k = 1:height(tableData)
    id = tableData.ID(k);
    mac = tableData.MAC(k);
    fprintf(fid1, '[`%s - %s`](coefficients/%s/history.md)  \n', id, mac, id);
end
fclose(fid1);

tableData = sortrows(tableData, "MAC");

fid2 = fopen("../pedals_by_MAC.md","w");
for k = 1:height(tableData)
    id = tableData.ID(k);
    mac = tableData.MAC(k);
    fprintf(fid2, '[`%s - %s`](coefficients/%s/history.md)  \n', mac, id, id);
end
fclose(fid2);


% foo("PDX1-R001751","FA:11:D4:A8:C5:B0","auto");
% 
% 
% function foo(ID, MAC,~)
% string_to_add  = "2026-06-04T11:00:00.000 - INFO - MAC address was read - ["+MAC+"]";
% AxleCalibrator.add2history(ID, string_to_add, true);
% end
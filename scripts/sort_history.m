clc; clear;

baseDir = "C:\Projects\pax-models\pax-calibration\coefficients";
files = dir(fullfile(baseDir, "*\history.md"));

for k = 1:numel(files)

    fullPath = fullfile(files(k).folder, files(k).name);
    lines = readlines(fullPath);

    % --- basic structure checks ---
    assert(lines(1) == "```", "Missing opening ``` in: " + fullPath);

    % allow optional empty last line, but enforce structure
    assert(lines(end) == "" || strlength(lines(end)) == 0, ...
        "File must end with newline in: " + fullPath);

    % remove first and last structure lines
    body = lines(2:end);
    body = body(strlength(body) > 0);

    % --- sort check / enforce ---
    sortedBody = sort(body);
    % assert(isequal(body, sortedBody), ...
    %     "History not sorted in: " + fullPath);

    % --- rewrite sorted version ---
    body = sortedBody;

    % rebuild file
    newLines = ["```"; body; ""];

    fid = fopen(fullPath, "w");
    fprintf(fid, "%s\n", newLines);
    fclose(fid);

end

disp("All history files validated and sorted.");
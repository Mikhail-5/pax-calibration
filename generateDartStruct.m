function generateDartStruct(structVar, varName)
    dartCode = sprintf('final Map<String, dynamic> %s = %s;\n', varName, dartMap(structVar, 0));
    fprintf('%s\n', dartCode);
end

function dart = dartMap(val, indent)
    pad = repmat('  ', 1, indent);
    if isstruct(val)
        dart = sprintf('{\n');
        fields = fieldnames(val);
        for i = 1:numel(fields)
            f = fields{i};
            fieldVal = val.(f);
            nested = dartMap(fieldVal, indent + 1);
            dart = [dart, sprintf('%s  ''%s'': %s,\n', pad, f, nested)];
        end
        dart = [dart, sprintf('%s}', pad)];
    elseif ischar(val) || isstring(val)
        dart = sprintf('''%s''', char(val));
    elseif isnumeric(val)
        if isscalar(val)
            dart = sprintf('%g', val);
        else
            vals = join(string(num2cell(val)), ', ');
            dart = sprintf('[%s]', vals);
        end
    else
        dart = 'null'; % fallback
    end
end

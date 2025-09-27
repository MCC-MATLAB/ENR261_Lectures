function testKitchenInventoryScript()
    scriptName = 'kitchenInventory.m';
    enforceScript(scriptName);
    enforceGetInventoryListCall(scriptName);
    disp('kitchenInventory script structure looks good.');
end

function enforceScript(fileName)
    src = fileread(fileName);
    lines = regexp(src, '\r?\n', 'split');
    for i = 1:numel(lines)
        trimmed = strtrim(lines{i});
        if isempty(trimmed) || startsWith(trimmed, '%')
            continue;
        end
        assert(~startsWith(trimmed, 'function', 'IgnoreCase', true), ...
            'kitchenInventory must be delivered as a script, not a function.');
        break;
    end
end

function enforceGetInventoryListCall(fileName)
    src = fileread(fileName);
    pattern = 'getInventoryList\s*\(([^)]*)\)';
    matches = regexp(src, pattern, 'tokens');
    assert(~isempty(matches), ...
        'kitchenInventory must call getInventoryList with a filename argument.');
    hasArgument = false;
    for k = 1:numel(matches)
        args = strtrim(matches{k}{1});
        if ~isempty(args)
            hasArgument = true;
            break;
        end
    end
    assert(hasArgument, ...
        'kitchenInventory must pass a filename to getInventoryList.');
end

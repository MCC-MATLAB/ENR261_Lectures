function testProcessGearRatios()
    % Create a test CSV file to simulate input
    driverTeeth = [12; 15; 20];
    drivenTeeth = [24; 30; 60];
    testData = table(driverTeeth, drivenTeeth);
    inputFileName = 'gear_data.csv';
    outputFileName = 'gear_ratios_output.csv';

    cleanup(outputFileName);
    cleanup(inputFileName);

    enforceScript('processGearRatios.m');

    % Missing input file should be handled gracefully
    try
        missingOutput = evalc('processGearRatios;'); %#ok<NOPRT>
    catch ME
        cleanup(outputFileName);
        rethrow(ME);
    end

    assert(~isfile(outputFileName), ...
        'processGearRatios should not create an output file when the input file is missing.');
    expectedMessage = sprintf('File "%s" not found. Please provide input data and rerun.', inputFileName);
    assert(contains(missingOutput, expectedMessage), ...
        'processGearRatios should print the required missing-file message.');

    % Write the test data to the expected script input
    writetable(testData, inputFileName);

    try
        processGearRatios; %#ok<NOPRT> % script should execute without arguments
    catch ME
        cleanup({inputFileName, outputFileName});
        rethrow(ME);
    end

    % Check the output CSV file
    result = readtable(outputFileName);

    % Validate the gear ratios column
    expectedRatios = [2.00; 2.00; 3.00];
    assert(all(abs(result.gearRatio - expectedRatios) < 1e-6), ...
        'Gear ratios do not match expected values');

    % Clean up
    cleanup(outputFileName);

    disp('All tests for processGearRatios passed.');
end

function cleanup(filename)
    if isfile(filename)
        delete(filename);
    end
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
            'processGearRatios must be delivered as a script, not a function.');
        break;
    end
end

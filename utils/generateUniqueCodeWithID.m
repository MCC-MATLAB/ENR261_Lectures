function [code, id] = generateUniqueCodeWithID(name, description)
    % generateUniqueCodeWithID Generates a unique random alphanumeric code with an ID
    %   [code, id] = generateUniqueCodeWithID(name, description) generates a 12-character
    %   alphanumeric code, ensures its uniqueness by checking against existing
    %   codes in 'codes.csv', assigns an auto-incremented ID, and stores the code
    %   along with the provided name and description in the CSV file.
    %
    %   Inputs:
    %       name        - A string representing the name associated with the code
    %       description - A string describing the code
    %
    %   Outputs:
    %       code - The generated unique alphanumeric code
    %       id   - The assigned numerical identifier

    % Define the storage file name
    storageFile = 'codes.csv';
    
    % Define the possible characters (A-Z, 0-9)
    chars = ['A':'Z' '0':'9'];
    codeLength = 12;
    
    % Initialize existing data
    if isfile(storageFile)
        try
            existingData = readtable(storageFile, 'ReadVariableNames', true);
            existingCodes = existingData.Code;
            existingIDs = existingData.ID;
            if isempty(existingIDs)
                nextID = 1;
            else
                nextID = max(existingIDs) + 1;
            end
        catch
            error('Failed to read the existing data from %s.', storageFile);
        end
    else
        existingCodes = string.empty;
        nextID = 1;
    end
    
    % Function to generate a random code
    generateCode = @() strjoin(cellstr(chars(randi(numel(chars), 1, codeLength))), '');
    
    % Generate a unique code
    maxAttempts = 1000;
    for attempt = 1:maxAttempts
        newCode = generateCode();
        if ~ismember(newCode, existingCodes)
            code = newCode;
            id = nextID;
            break;
        end
        if attempt == maxAttempts
            error('Failed to generate a unique code after %d attempts.', maxAttempts);
        end
    end
    
    % Prepare the new entry with ID
    newEntry = table(id, {code}, {name}, {description}, ...
        'VariableNames', {'ID', 'Code', 'Name', 'Description'});
    
    % Write to CSV
    if isfile(storageFile)
        try
            writetable(newEntry, storageFile, 'WriteMode', 'append');
        catch
            error('Failed to append the new entry to %s.', storageFile);
        end
    else
        try
            writetable(newEntry, storageFile);
        catch
            error('Failed to create the storage file %s.', storageFile);
        end
    end
end

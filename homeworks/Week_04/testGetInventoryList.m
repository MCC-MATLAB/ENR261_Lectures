function testGetInventoryList()
    % Test for getInventoryList function

    % Create a temporary test file
    testFile = 'test_inventory.csv';
    cleanup(testFile);

    try
        % File missing scenario should be handled gracefully
        try
            inventory = getInventoryList(testFile);
        catch ME
            cleanup(testFile);
            error('getInventoryList should return -1 when the inventory file is missing, but it threw: %s', ME.message);
        end
        assert(isequal(inventory, -1), ...
            'getInventoryList should return -1 when the inventory file is missing.');

        % Add some items (function should create the file automatically)
        addItemToStock(testFile, '123456789012', 'Tomato', 5);
        addItemToStock(testFile, '987654321098', 'Onion', 10);
    
        % Test inventory list
        inventory = getInventoryList(testFile);
        assert(istable(inventory), 'getInventoryList should return a table when data exists.');
        assert(height(inventory) == 2, 'Inventory table should contain two rows.');
        assert(string(inventory.upc(1)) == "123456789012");
        assert(string(inventory.ingredient(2)) == "Onion");
        assert(inventory.qty(2) == 10);
    catch ME
        cleanup(testFile);
        rethrow(ME)
    end

    % Clean up
    cleanup(testFile);
    
    disp('getInventoryList passed.');
end

function cleanup(filename)
    if isfile(filename)
        delete(filename);
    end
end

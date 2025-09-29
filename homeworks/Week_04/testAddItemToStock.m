function testAddItemToStock()
    % Test for addItemToStock function

    % Create a temporary test file
    testFile = 'test_inventory.csv';
    cleanup(testFile);

    try
        % Add an item when the file does not yet exist (function should create it)
        addItemToStock(testFile, '123456789012', 'Tomato', 5);

        assert(isfile(testFile), ...
            'addItemToStock should create the inventory file when it does not exist.');

        % Read the file and check the first entry
        inventory = readtable(testFile);
        assert(height(inventory) == 1, 'Inventory should contain a single entry.');
        assert(string(inventory.upc(1)) == "123456789012", ...
            'UPC value mismatch after adding the item.');
        assert(string(inventory.ingredient(1)) == "Tomato", ...
            'Ingredient name mismatch after adding the item.');
        assert(inventory.qty(1) == 5, ...
            'Quantity mismatch after adding the item.');

        % Add a second item and ensure it appends without overwriting
        addItemToStock(testFile, '987654321098', 'Onion', 10);
        inventory = readtable(testFile);
        assert(height(inventory) == 2, ...
            'Inventory should contain two entries after adding a second item.');
        assert(string(inventory.upc(2)) == "987654321098", ...
            'Second UPC value mismatch after adding the item.');
        assert(string(inventory.ingredient(2)) == "Onion", ...
            'Second ingredient name mismatch after adding the item.');
        assert(inventory.qty(2) == 10, ...
            'Second quantity mismatch after adding the item.');
    catch ME
        % Clean up
        cleanup(testFile);
        rethrow(ME)
    end
    
    cleanup(testFile);
    disp('addItemToStock passed.');
end

function cleanup(filename)
    if isfile(filename)
        delete(filename);
    end
end

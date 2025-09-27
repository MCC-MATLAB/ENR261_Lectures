function testGetStockQty()
    % Test for getStockQty function

    % Create a temporary test file
    testFile = 'test_inventory.csv';
    cleanup(testFile);

    try
        % Add some items
        addItemToStock(testFile, 123456789012, 'Tomato', 5);
        addItemToStock(testFile, 987654321098, 'Onion', 10);

        % Test for existing UPC
        qty = getStockQty(testFile, 123456789012);
        assert(isscalar(qty), 'Quantity should be returned as a scalar.');
        assert(qty == 5);

        % Add a duplicate UPC to ensure the function returns just one value
        addItemToStock(testFile, 123456789012, 'Tomato', 12);
        qty = getStockQty(testFile, 123456789012);
        assert(isscalar(qty), 'Quantity should be scalar even with duplicate UPCs.');
        assert(qty == 5, 'Function should return the first matching UPC entry.');
        
        % Test for non-existing UPC
        qty = getStockQty(testFile, 0);
        assert(qty == -1);
    catch ME
        cleanup(testFile);
        rethrow(ME)
    end

    % Clean up
    cleanup(testFile);
    
    disp('getStockQty passed.');
end

function cleanup(filename)
    if isfile(filename)
        delete(filename);
    end
end

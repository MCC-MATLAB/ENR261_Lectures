function testGetStockQty()
    % Test for getStockQty function

    % Create a temporary test file
    testFile = 'test_inventory.csv';
    cleanup(testFile);

    try
        % File missing scenario should be handled gracefully
        try
            qty = getStockQty(testFile, '123456789012');
        catch ME
            error('getStockQty should return -1 when the inventory file is missing, but it threw: %s', ME.message);
        end
        assert(qty == -1, ...
            'getStockQty should return -1 when the inventory file is missing.');

        % Add some items (function should create the file automatically)
        addItemToStock(testFile, '123456789012', 'Tomato', 5);
        addItemToStock(testFile, '987654321098', 'Onion', 10);

        % Test for existing UPC
        qty = getStockQty(testFile, '123456789012');
        assert(isscalar(qty), 'Quantity should be returned as a scalar.');
        assert(qty == 5, ...
            'Expected quantity 5 for UPC 123456789012 after adding initial inventory item.');

        % Add a duplicate UPC to ensure the function returns just one value
        addItemToStock(testFile, '123456789012', 'Tomato', 12);
        qty = getStockQty(testFile, '123456789012');
        assert(isscalar(qty), 'Quantity should be scalar even with duplicate UPCs.');
        assert(qty == 5, 'Function should return the first matching UPC entry.');
        
        % Test for non-existing UPC
        qty = getStockQty(testFile, '000000000000');
        assert(qty == 0, ...
            'getStockQty should return 0 when the UPC is not found.');
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

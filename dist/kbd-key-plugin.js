(function() {
    // Define a map to convert specific commands to their HTML representations
    const commandMap = {
        'ctrl+c': '<kbd class="kbc-button">ctrl</kbd>+<kbd class="kbc-button">c</kbd>',
        'ctrl+v': '<kbd class="kbc-button">ctrl</kbd>+<kbd class="kbc-button">v</kbd>',
        'ctrl+a': '<kbd class="kbc-button">ctrl</kbd>+<kbd class="kbc-button">a</kbd>',
        'up arrow': '<kbd class="kbc-button">&uarr;</kbd>',
        'down arrow': '<kbd class="kbc-button">&darr;</kbd>',
        'left arrow': '<kbd class="kbc-button">&larr;</kbd>',
        'right arrow': '<kbd class="kbc-button">&rarr;</kbd>',
        'enter': '<kbd class="kbc-button">enter</kbd>',
        'shift': '<kbd class="kbc-button">shift</kbd>'
        // Add more mappings as needed
    };

    function replaceCommandWithKbd() {
        console.log('replaceCommandWithKbd function executed');

        // Find all <span class="token command"> elements in the document
        const commandElements = document.querySelectorAll('span.token.command');

        // Iterate over each <span class="token command"> element
        commandElements.forEach(function(element) {
            // Check if the element already contains a <kbd> tag
            if (!element.querySelector('kbd')) {
                // Preserve the original content in a data attribute if not already preserved
                if (!element.dataset.originalContent) {
                    console.log('Preserving original content:', element.innerHTML);
                    element.dataset.originalContent = element.innerHTML;
                }

                // Get the original text content from the data attribute and remove < and >
                const originalText = element.dataset.originalContent;
                const commandText = originalText.replace(/&lt;|&gt;/g, '');

                // Create the new <kbd> element with the cleaned text
                const kbdElement = `<kbd class="kbc-button">${commandText}</kbd>`;

                // Replace the inner HTML of the <span> element with the new <kbd> element
                console.log('Replacing content with <kbd>:', commandText);
                element.innerHTML = kbdElement;
            }
        });
    }



    // Expose the function to be called externally
    window.KbdPlugin = {
        replaceCommandWithKbd: replaceCommandWithKbd
    };

})();

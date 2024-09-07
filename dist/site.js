// JavaScript to toggle the active class
const buttons = document.getElementsByClassName('animated');

setInterval(() => {
    for (let i = 0; i < buttons.length; i++) {
        buttons[i].classList.toggle('active');
        buttons[i].offsetWidth;
    }
}, 2000);


function transposeMatrix() {
    const matrixContainer = document.getElementById('matrix');
    const cells = matrixContainer.getElementsByClassName('matrix-cell');

    // Create a 2D array from the grid
    let matrix = [
        [cells[0].textContent, cells[1].textContent, cells[2].textContent],
        [cells[3].textContent, cells[4].textContent, cells[5].textContent],
        [cells[6].textContent, cells[7].textContent, cells[8].textContent]
    ];

    // Transpose the matrix
    let transposed = [
        [matrix[0][0], matrix[1][0], matrix[2][0]],
        [matrix[0][1], matrix[1][1], matrix[2][1]],
        [matrix[0][2], matrix[1][2], matrix[2][2]]
    ];

    // Animate the transpose
    for (let i = 0; i < 3; i++) {
        for (let j = 0; j < 3; j++) {
            let index = i * 3 + j;
            cells[index].classList.add('transposing');
            setTimeout(() => {
                cells[index].textContent = transposed[i][j];
                cells[index].classList.remove('transposing');
            }, 1000);
        }
    }
}
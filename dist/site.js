// JavaScript to toggle the active class
const buttons = document.getElementsByClassName('animated');

setInterval(() => {
    for (let i = 0; i < buttons.length; i++) {
        buttons[i].classList.toggle('active');
        buttons[i].offsetWidth;
    }
}, 2000);
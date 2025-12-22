const container = document.querySelector('.container-auth');
const registerBtns = document.querySelectorAll('.SignUpLink');
const loginBtns = document.querySelectorAll('.SignInLink');

if (container) {
    registerBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            container.classList.add('active');
        });
    });

    loginBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            container.classList.remove('active');
        });
    });
}

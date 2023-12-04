const passwordEye = document.querySelector('.eyeImg');
const passwordField = document.querySelector('.password_field');
passwordEye.addEventListener('click', function () {
    passwordField.type === 'password' ? passwordField.type='text' : passwordField.type = 'password'
})
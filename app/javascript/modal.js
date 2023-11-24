document.addEventListener('click', function (event) {
    const target = event.target;
    const modal = document.querySelector('.modal-container');
    if (target.classList.contains('modal_btn')) {
      event.preventDefault();
      modal.style.display = 'none';
    }
});
  


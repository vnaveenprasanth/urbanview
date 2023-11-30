document.addEventListener("turbo:load", function () {
  const enableEventCheckbox = document.querySelector('.enable-event-checkbox');
  const eventDatesFields = document.querySelector('.event-dates');

    enableEventCheckbox.addEventListener('change', function () {
      eventDatesFields.querySelectorAll('input[type="datetime-local"]').forEach(function (input) {
        input.disabled = !enableEventCheckbox.checked;
      });
    });
});
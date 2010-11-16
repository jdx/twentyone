$(document).ready(function() {
    setup_habit_view();
    setup_habit_create();
    setup_login();
});

function setup_login() {
  $('#no-facebook').click(function() {
    $('#regular-login').show();
  });
}

function setup_habit_create() {
  $('#samples ul li').click(function() {
      $('#what').attr('value', $(this).text());
  });
}

function setup_habit_view() {
  $('#calendar .today').click(function() {
      $.ajax({
        type: 'POST',
        url: '/habit/toggle_today.json',
        success: function(data) {
          if(data['status'] == 'Created') {
            $('#calendar .today .container').append('<span class="x">X</span>');
            days_completed = $('#days-completed');
            num_days_completed = parseInt(days_completed.text()) + 1;
            days_completed.text(num_days_completed);
          }
          else {
            $('#calendar .today .container .x').remove();
            days_completed = $('#days-completed');
            num_days_completed = parseInt(days_completed.text()) - 1;
            days_completed.text(num_days_completed);
          }
        },
      });
  });
}

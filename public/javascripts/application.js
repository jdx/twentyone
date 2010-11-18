$(document).ready(function() {
    setup_habit_view();
    setup_habit_create();
    setup_login();
});

function setup_login() {
  $('#no-facebook').click(function() {
    $('#regular-login').slideDown();
  });
}

function setup_habit_create() {
  $('#create-habit-ideas ul li').click(function() {
      $('#create-habit-what').attr('value', $(this).text());
  });
}

function setup_habit_view() {
  $('#notification-edit-link').click(setup_edit_notification);
  $('#calendar .today').click(function() {
      $.ajax({
        type: 'POST',
        url: '/habit/toggle_today.json',
        success: function(data) {
          if(data['status'] == 'Created') {
            var x = $('<span style="display:none;" class="x">X</span>');
            $('#calendar .today .container').append(x);
            x.fadeIn();
            days_completed = $('#days-completed');
            num_days_completed = parseInt(days_completed.text()) + 1;
            days_completed.text(num_days_completed);
          }
          else {
            $('#calendar .today .container .x').fadeOut(function() {
              $(this).remove();
            });
            days_completed = $('#days-completed');
            num_days_completed = parseInt(days_completed.text()) - 1;
            days_completed.text(num_days_completed);
          }
        },
      });
  });
}

function setup_edit_notification() {
  link = $(this).hide();
  form = $('#notification-edit-form').css('display', 'inline');
  select = form.find('select');
  select.val(link.attr('hour'));
  select.change(function() {
    hour = $(this).val();
    $.ajax({
      type:'POST',
      url:'/notification/edit',
      data:{'hour':hour},
      success: function(data) {
        form.hide();
        link.show();
        link.attr('hour', data['hour']); 
        link.text(data['time']); 
      },
      error: function(data) {
        form.hide();
        link.show();
      }
    });
  });
}

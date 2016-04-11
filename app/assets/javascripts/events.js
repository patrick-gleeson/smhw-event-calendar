$(document).ready(function() {
  var $eventForm= $('#new_event_form');
  var $alertBox = $('#alert_box');

  // Create the calendar
  $('#calendar').fullCalendar({
    firstDay: 1,
    defaultView: 'basicWeek',
    header: { left: '', center: '', right: '' },
    columnFormat: 'dddd Do MMM',
    height: 250
    //TODO: load event feed
  });

  // Style first word in calendar column header
  // differently
  $('.fc-day-header').each(function() {
    var content = $(this).html();
    var firstSpaceIndex = content.indexOf(' ');
    if(firstSpaceIndex == -1) {
        firstSpaceIndex = content.length;
    }

    $(this).html('<span class="first-word">'
                  + content.substring(0, firstSpaceIndex)
                  + '</span>'
                  + content.substring(firstSpaceIndex, content.length));
  });


  // Make the 'create event' link a toggle
  $('.event_form_toggler').click(function() {
    $('.event_form_togglee').toggle();
  });

  // Add datepicker
  setupDatePicker('event_start_date');
  setupDatePicker('event_end_date');

  function setupDatePicker(inputId) {
    return new Pikaday({ field: $('#' + inputId)[0], firstDay: 1 });
  }

  // Process form submission
  $eventForm.submit(function() {
    $eventForm.hide();
  }).on("ajax:success", function(e, data, status, xhr)  {
    if (xhr.status == 200) {
      showAlertBox(data.message, true);
      $eventForm.trigger('reset');
    } else {
      showAlertBox(data.message, false);
      $eventForm.show();
    }
  }).on("ajax:error", function(e, data, status, xhr)  {
      showAlertBox('Something went wrong', false);
      $eventForm.show();
  });

  function showAlertBox(message, isSuccessful) {
    $alertBox.removeClass(isSuccessful ? 'error' : 'success');
    $alertBox.addClass(isSuccessful ? 'success' : 'error');
    $alertBox.html(message);
    $alertBox.show();
  }

  //TODO: Refresh calendar on successful form submission

});


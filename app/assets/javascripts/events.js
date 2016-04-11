$(document).ready(function() {
  var $eventForm= $('#new_event_form');
  var $alertBox = $('#alert_box');
  var $togglees = $('.event_form_togglee');

  // Create the calendar
  var $calendar = setupCalendar();

  // Style first word in calendar column header
  // differently
  highlightFirstWords('.fc-day-header');

  // Make the 'create event' link a toggle
  $('.event_form_toggler').click(function() {
    $togglees.toggle();
  });

  // Add datepicker
  setupDatePicker('event_start_date');
  setupDatePicker('event_end_date');

  // Process form submission
  $eventForm.submit(function() {
    $togglees.toggle();
  }).on("ajax:success", function(e, data, status, xhr)  {
    if (xhr.status == 200) {
      showAlertBox(data.message, true);
      $eventForm.trigger('reset');
      $calendar.fullCalendar('refetchEvents');
    } else {
      showAlertBox(data.message, false);
      $togglees.toggle();
    }
  }).on("ajax:error", function(e, data, status, xhr)  {
      showAlertBox('Something went wrong', false);
      $togglees.toggle();
  });

  function setupCalendar() {
    return $('#calendar').fullCalendar({
      firstDay: 1,
      defaultView: 'basicWeek',
      header: { left: '', center: '', right: '' },
      columnFormat: 'dddd Do MMM',
      height: 250,
      eventSources: [{
        url: '/api/events',
        color: 'darkorange',
        textColor: 'black'
      }]
    });
  }

  function highlightFirstWords(selector) {
    $(selector).each(function() {
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
  }

  function setupDatePicker(inputId) {
    return new Pikaday({ field: $('#' + inputId)[0], firstDay: 1 });
  }

  function showAlertBox(message, isSuccessful) {
    $alertBox.removeClass(isSuccessful ? 'error' : 'success');
    $alertBox.addClass(isSuccessful ? 'success' : 'error');
    $alertBox.html(message);
    $alertBox.show();
  }

});


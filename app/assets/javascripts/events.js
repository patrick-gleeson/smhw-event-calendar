$(document).ready(function() {

  $('#calendar').fullCalendar({
    firstDay: 1,
    defaultView: 'basicWeek',
    header: { left: '', center: '', right: '' },
    columnFormat: 'dddd Do MMM',
    height: 250
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

});

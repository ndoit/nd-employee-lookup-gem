function do_alert(msg) {
  $('#alert_text').text(msg);
  $('#alert_box_div').show();
}
function build_employee_selection (input) {
  var emp_string =  '<div class="row ">';
  emp_string += '<div class="large-12 medium-12 small-12 columns left ">';
  emp_string += '<span class="text_nw ldc_display_bold">Name: <span class="emp_sel_last">' + input.last_name + '</span>, <span class="emp_sel_first">' + input.first_name + '</span><span class="emp_sel_pidm">' + input.pidm + '</span></span>';
  emp_string += '</div></div>';
  emp_string += ' <div class="row ldc_display">';
  emp_string += ' <div class="large-1 medium-1 small-3 columns left"><label class="text_nw">Net ID:</label></div>';
  emp_string += ' <div class="large-3 medium-3 small-9 columns left"><span class="emp_sel_net_id">' + input.net_id +'</span></div>';
  emp_string += ' <div class="large-2 medium-2 small-3 columns left"><label class="text_nw">Home Orgn: </label></div>';
  emp_string += ' <div class="large-6 medium-6 small-9 columns left"><span class="emp_sel_home_org">'+ input.home_orgn + '</span>, <span class="emp_sel_home_org_desc">' + input.home_orgn_desc + '</span></div>';
  emp_string += ' </div>';
  emp_string += ' <div class="row ldc_display">';
  emp_string += ' <div class="large-1 medium-1 small-3 columns left"><label class="text_nw">ND ID:</label></div>';
  emp_string += ' <div class="large-3 medium-3 small-9 columns left"><span class="emp_sel_nd_id">' + input.nd_id + '</span></div>';
  emp_string += ' <div class="large-2 medium-2 small-3 columns left"><label class="text_nw">Primary Title: </label></div>';
  emp_string += ' <div class="large-6 medium-6 small-9 columns left"><span class="emp_sel_title">' + input.primary_title + '</span></div>';
  emp_string += ' </div>';

  $('#select_employee_list').append('<div class="select_box emp_sel_box" id="emp'+input.nd_id +'">' + emp_string + '</div>');

}
function doActionOnReturn( e, field_id) {

  var key=e.keyCode || e.which;
  if (key == 13) {
    switch (field_id) {
      case "s_net_id":
      case "s_last_name":
      case "s_first_name": emp_lookup(); break;
      case "s_end_date": if ($('#b_find_jobs').length > 0) $('#b_find_jobs').click();
                         else if ($('#b_find_pay').length > 0) $('#b_find_pay').click(); break;
      case "f_notification_input_last":
      case "f_notification_input_first":
      case "f_notification_input_net_id": find_notification_employees(); break;
    }
  }
}
function enable_notifications() {
  $('#b_add_notification').click( function() {
    show_search_for_notification();  });
  $('#b_notification_add_cancel').click( function() {
    $('#notification_entry').foundation('reveal','close');
    $('#notification_find_employee_processing').removeClass("ajax-processing");
  });
  $('#b_notification_find_employee').click( function() {
    find_notification_employees();  });
}
function disableConfirmExit() {
    window.onbeforeunload = null;
    $('.top-bar-section >ul>li>a').on("click", function(e) {
      return true;

    });
}

function emp_lookup() {
  var lname = encodeURIComponent($('#s_last_name').val());
  var fname = encodeURIComponent($('#s_first_name').val());
  var netid = encodeURIComponent($('#s_net_id').val());

  var lookup_url = "/nd_employee_lookup/employee";
  if (lname != "") {
    lookup_url = lookup_url + '/l/' + lname;
    if (fname != "")
      lookup_url = lookup_url + '/' + fname;
  }
  else {
    if (netid != "")  lookup_url = lookup_url + '/' + netid;
    else  {
        $('#employee_invalid_entries').show();
        return;
    }
  }
//  lookup_url = lookup_url + ".json";
  $('#find_employee_processing').addClass("ajax-processing");
  $.ajax({ url: lookup_url,
    contentType: "json",
    dataType: "json",
    cache: false,
    error: function(XMLHttpRequest, textStatus, errorThrown) {
                    $('#find_employee_processing').removeClass("ajax-processing");
                    do_alert("An error has occurred while attempting to retrieve employee data.  Please confirm that all necessary web services are running. (" + errorThrown + ")");                 },
    success: function (data, status, xhr) {
      if (data.length == 0) {
        $('#employee_not_found').show();
      }
      else {
        if (data.length == 1) {
          if (data[0].Employee == "None") {
            $('#employee_not_found').show();
          }
          else display_employee( data[0]);
        }
        else {
          $('#select_employee_list').html('');
          for (i = 0; i < data.length; i++) {
            build_employee_selection (data[i]);
          }
          $('#select_employee').foundation('reveal', 'open');
          $('.emp_sel_box').click( function() {
            var  selected_employee = set_employee_input ( $(this).attr('id'));
            display_employee( selected_employee) ;
            $('#select_employee').foundation('reveal', 'close');
          });
        }
      }
      $('#find_employee_processing').removeClass("ajax-processing");
    }
  });

}

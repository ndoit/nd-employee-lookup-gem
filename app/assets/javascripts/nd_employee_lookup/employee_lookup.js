function set_employee_input ( emp_sel_box) {
  var emp_array = {};

  var last_span = $('#'+emp_sel_box).find('span.emp_sel_last');
  emp_array.last_name = $('#'+emp_sel_box).find('span.emp_sel_last').text();
  emp_array.first_name = $('#'+emp_sel_box).find('span.emp_sel_first').text();
  emp_array.pidm = $('#'+emp_sel_box).find('span.emp_sel_pidm').text();
  emp_array.net_id = $('#'+emp_sel_box).find('span.emp_sel_net_id').text();
  emp_array.home_orgn = $('#'+emp_sel_box).find('span.emp_sel_home_org').text();
  emp_array.home_orgn_desc = $('#'+emp_sel_box).find('span.emp_sel_home_org_desc').text();
  emp_array.nd_id = $('#'+emp_sel_box).find('span.emp_sel_nd_id').text();
  emp_array.primary_title = $('#'+emp_sel_box).find('span.emp_sel_title').text();
  return emp_array;
}
function employee_section(mode,input) {
  if (mode == "display") {
    if (input !== undefined) {
      $('#employee_name').html(input.last_name + ", " + input.first_name);
      $('#employee_net_id').html(input.net_id);
      $('#employee_nd_id').html(input.nd_id);
      $('#employee_home_org').html(input.home_orgn + ", " + input.home_orgn_desc);
      $('#employee_title').html(input.primary_title);
      $('#pidm_input').val(input.pidm);
      $('#nd_id_input').val(input.nd_id);
      $('#net_id_input').val(input.net_id);
      $('#last_name_input').val(input.last_name);
      $('#first_name_input').val(input.first_name);
      $('#home_orgn_input').val(input.home_orgn);
      $('#home_orgn_desc_input').val(input.home_orgn_desc);
      $('#primary_title_input').val(input.primary_title);
    }
    $('#employee_edit').hide();
    $('#employee_row').css("margin-bottom", "0px");
    $('#edit_employee_button').show();
    $('#close_edit_employee_button').hide();
    $('#employee_display').show();
  }
  if (mode == "edit") {
    $('#employee_display').hide();
    $('#edit_employee_button').hide();
    $('#close_edit_employee_button').show();
    $('#employee_edit').show();
    $('#employee_row').css("margin-bottom", "100px");

  }
}
function display_employee(input) {
  $('#employee_not_found').hide();
  $('#employee_invalid_entries').hide();
  employee_section("display",input);
  $('#job_id_input').val("");
  $('#pict_code_input').val("");
  // $('#lu_date_edit').show();
  // $('#lu_date_display').hide();
  $('#lu_date_row').show();
  $('#display_job_lookup_errors').hide();
  $('#display_pay_lookup_errors').hide();
  $('#employee_edit').hide();
  $('#employee_row').css("margin-bottom", "0px");
  $('#edit_employee_button').show();
  $('#close_edit_employee_button').hide();
  $('#employee_display').show();
  $('#s_start_date').focus();
  // clear_job_data();
}
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

function change_employee() {
  $('#employee_not_found').hide();
  $('#employee_invalid_entries').hide();
  employee_section("edit");
  $('#lu_date_row').hide();
  $('#job_display_row').hide();
  $('#job_ld_rows').hide();
  $('#auth_users').hide();
  $('#pay_data_not_found').hide();
}
function close_without_editing_employee() {
  $('#employee_not_found').hide();
  $('#employee_invalid_entries').hide();
  $('#edit_employee_button').show();
  $('#close_edit_employee_button').hide();
  $('#employee_edit').hide();
  $('#employee_row').css("margin-bottom", "0px");
  $('#employee_display').show();
}
function emp_lookup() {
  var lname = encodeURIComponent($('#s_last_name').val());
  var fname = encodeURIComponent($('#s_first_name').val());
  var netid = encodeURIComponent($('#s_net_id').val());

  var lookup_url = employee_search_url();
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
          else if (data[0].Employee == "Error") {
            $('#employee_lookup_api_error').show();
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

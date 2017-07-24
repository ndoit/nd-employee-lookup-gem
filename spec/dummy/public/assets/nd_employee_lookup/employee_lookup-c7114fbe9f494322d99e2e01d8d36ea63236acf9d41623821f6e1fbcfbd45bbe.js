function nd_employee_lookup_set_and_display_employee(employee_data) {
  $('#employee_lookup_employee_net_id').val(employee_data.net_id);
  $('#employee_lookup_employee_nd_id').val(employee_data.nd_id);
  $('#employee_lookup_employee_last_name').val(employee_data.last_name);
  $('#employee_lookup_employee_middle_init').val(employee_data.middle_init);
  $('#employee_lookup_employee_first_name').val(employee_data.first_name);
  $('#employee_lookup_employee_home_orgn').val(employee_data.home_orgn);
  $('#employee_lookup_employee_home_orgn_desc').val(employee_data.home_orgn_desc);
  $('#employee_lookup_employee_pidm').val(employee_data.pidm);
  $('#employee_lookup_employee_primary_title').val(employee_data.primary_title);
  $('#employee_lookup_employee_employee_status').val(employee_data.employee_status);
  $('#employee_lookup_employee_ecls_code').val(employee_data.ecls_code);
  $('#employee_lookup_employee_last_paid_date').val(employee_data.last_paid_date);
  $('#employee_lookup_employee_employee_pict_code').val(employee_data.employee_pict_code);
  $('#employee_lookup').submit();
}

function nd_employee_lookup_set_employee_input (emp_sel_box) {
  var emp_array = {};

  var last_span = $('#'+emp_sel_box).find('span.emp_sel_last');
  emp_array.last_name = $('#'+emp_sel_box).find('span.emp_sel_last').text();
  emp_array.middle_init = $('#'+emp_sel_box).find('span.emp_sel_middle').text();
  emp_array.first_name = $('#'+emp_sel_box).find('span.emp_sel_first').text();
  emp_array.pidm = $('#'+emp_sel_box).find('span.emp_sel_pidm').text();
  emp_array.net_id = $('#'+emp_sel_box).find('span.emp_sel_net_id').text();
  emp_array.home_orgn = $('#'+emp_sel_box).find('span.emp_sel_home_orgn').text();
  emp_array.home_orgn_desc = $('#'+emp_sel_box).find('span.emp_sel_home_orgn_desc').text();
  emp_array.nd_id = $('#'+emp_sel_box).find('span.emp_sel_nd_id').text();
  emp_array.primary_title = $('#'+emp_sel_box).find('span.emp_sel_title').text();
  emp_array.active_primary_title = $('#'+emp_sel_box).find('span.emp_sel_title').text();
  emp_array.employee_status = $('#'+emp_sel_box).find('span.emp_sel_status').text();
  emp_array.ecls_code = $('#'+emp_sel_box).find('span.emp_sel_ecls_code').text();
  emp_array.last_paid_date = $('#'+emp_sel_box).find('span.emp_sel_last_paid_date').text();
  emp_array.employee_pict_code = $('#'+emp_sel_box).find('span.emp_sel_pict_code').text();
  return emp_array;
}

function nd_employee_lookup_alert(msg) {
  $('#nd_employee_lookup_alert_text').text(msg);
  $('#nd_employee_lookup_alert_box_div').show();
}

function nd_employee_lookup_build_employee_selection (input) {
  var emp_string =  '<div class="row ">';
  emp_string += '<div class="large-12 medium-12 small-12 columns left ">';
  emp_string += '<strong><span>Name: <span class="emp_sel_last">' + input.last_name + '</span>, <span class="emp_sel_first">' + input.first_name + '</span><span class="emp_sel_pidm">' + input.pidm + '</span></span></strong>';
  emp_string += '<span class="emp_sel_middle">' + input.middle_init + '</span><span class="emp_sel_status">' + input.employee_status + '</span><span class="emp_sel_ecls_code">' + input.ecls_code + '</span><span class="emp_sel_last_paid_date">' + input.last_paid_date + '</span><span class="emp_sel_pict_code">' + input.employee_pict_code + '</span>';
  emp_string += '</div></div>';
  emp_string += ' <div class="row">';
  emp_string += ' <div class="large-2 medium-1 small-3 columns left"><label>NetID:</label></div>';
  emp_string += ' <div class="large-3 medium-3 small-9 columns left"><span class="emp_sel_net_id">' + (input.net_id || '') +'</span>' + (input.net_id ? '' : '(No NetID)') + '</div>';
  emp_string += ' <div class="large-2 medium-2 small-3 columns left"><label>Home Orgn: </label></div>';
  emp_string += ' <div class="large-5 medium-6 small-9 columns left"><span class="emp_sel_home_orgn">'+ input.home_orgn + '</span>, <span class="emp_sel_home_orgn_desc">' + input.home_orgn_desc + '</span></div>';
  emp_string += ' </div>';
  emp_string += ' <div class="row">';
  emp_string += ' <div class="large-2 medium-1 small-3 columns left"><label>ndID:</label></div>';
  emp_string += ' <div class="large-3 medium-3 small-9 columns left"><span class="emp_sel_nd_id">' + input.nd_id + '</span></div>';
  emp_string += ' <div class="large-2 medium-2 small-3 columns left"><label>Primary Title: </label></div>';
  if(only_show_active_primary_title) {
    emp_string += ' <div class="large-5 medium-6 small-9 columns left"><span class="emp_sel_title">' + (input.active_primary_title ? input.active_primary_title : '') + '</span></div>';
  } else {
    emp_string += ' <div class="large-5 medium-6 small-9 columns left"><span class="emp_sel_title">' + input.primary_title + '</span></div>';
  }
  emp_string += ' </div>';

  $('#nd_employee_lookup_select_employee_list').append('<div class="select_box emp_sel_box" id="emp'+input.nd_id +'">' + emp_string + '</div>');
}

function doActionOnReturn(e, field_id) {
  var key=e.keyCode || e.which;
  if (key == 13) {
    switch (field_id) {
      case "nd_employee_lookup_net_id":
      case "nd_employee_lookup_last_name":
      case "nd_employee_lookup_first_name": nd_employee_lookup_find(); break;
    }
  }
}

function nd_employee_lookup_find() {
  $('#nd_employee_lookup_alert_box_div').hide();
  var lname = encodeURIComponent($('#nd_employee_lookup_last_name').val());
  var fname = encodeURIComponent($('#nd_employee_lookup_first_name').val());
  var netid = encodeURIComponent($('#nd_employee_lookup_net_id').val());
  var state = encodeURIComponent($('#nd_employee_lookup_status').val());

  var lookup_url = '/employee-lookup/employee';
  if (state != "") {
    lookup_url = lookup_url + '/' + state;
  }
  if (netid != "") {
    lookup_url = lookup_url + '/' + netid;
  }
  else {
    if (lname != "") {
      lookup_url = lookup_url + '/l/' + lname;
      if (fname != "") lookup_url = lookup_url + '/' + fname;
    }
    else  {
      nd_employee_lookup_alert("Invalid entries.  You must provide part or all of the last name -OR- part or all of the NetID -OR- the ndID.  First name is optional.");
      return;
    }
  }
  $('#nd_employee_lookup_find_employee_processing').addClass("ajax-processing");
  $.ajax({ url: lookup_url,
    contentType: "json",
    dataType: "json",
    cache: false,
    error: function(XMLHttpRequest, textStatus, errorThrown) {
      $('#nd_employee_lookup_find_employee_processing').removeClass("ajax-processing");
      nd_employee_lookup_alert("An error has occurred while attempting to retrieve employee data.  Please confirm that all necessary web services are running. (" + errorThrown + ")");
    },
    success: function (data, status, xhr) {
      if (data.length == 0) {
        nd_employee_lookup_alert("An employee could not be found with the provided information.  Please check your entries and try again. ");
      }
      else {
        if (data.length == 1) {
          if (data[0].Employee == "None") {
            nd_employee_lookup_alert("An employee could not be found with the provided information.  Please check your entries and try again. ");
          }
          else if (data[0].Employee == "Error") {
            nd_employee_lookup_alert("The API for employee lookup returned an error.  Please check your code. ");
          }
          else {
            if(only_show_active_primary_title) {
              data[0].primary_title = data[0].active_primary_title;
            }
            $(document).trigger("nd_employee_lookup:employee_selected", data[0]);
          }
        }
        else {
          $('#nd_employee_lookup_select_employee_list').html('');
          for (i = 0; i < data.length; i++) {
            nd_employee_lookup_build_employee_selection (data[i]);
          }
          $('#nd_employee_lookup_select_employee').foundation('reveal', 'open');
          $('.emp_sel_box').click(function() {
            var  selected_employee = nd_employee_lookup_set_employee_input ($(this).attr('id'));
            $(document).trigger("nd_employee_lookup:employee_selected", selected_employee);
            $('#nd_employee_lookup_select_employee').foundation('reveal', 'close');
          });
        }
      }
      $('#nd_employee_lookup_find_employee_processing').removeClass("ajax-processing");
    }
  });
}
;

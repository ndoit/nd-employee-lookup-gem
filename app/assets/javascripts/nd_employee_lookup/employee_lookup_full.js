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
      // FIXME: ??? is this code still used anywhere at all...
      $('#active_primary_title_input').val(input.active_primary_title);
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

function change_employee() {
  $('#employee_not_found').hide();
  $('#employee_invalid_entries').hide();
  employee_section("edit");
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

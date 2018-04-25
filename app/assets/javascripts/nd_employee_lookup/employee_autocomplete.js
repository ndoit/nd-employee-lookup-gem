/* Add the class active_employee_net_id_input to your input field
 * Call set_active_employee_net_id_autocomplete in document ready
 * Select and change will call a function named
 * select_active_employee_net_id_input (net_id_field, net_id)  if it is available
 */

function set_active_employee_net_id_autocomplete() {

$(".active_employee_net_id_input").autocomplete({
  source: function( request, response) {
    $.ajax({
      url: "/employee-lookup/employee-basic/" + encodeURIComponent(request.term) + "/active",
      dataType: "json",
      delay: 1000,
      data: {
      },
      error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert("Lookup error for active employees. Please confirm that the HR/Payroll data web services are running. (" + errorThrown + ")");
      },
      success: function (data) {
        response( $.map(data, function( item) {
          return {
            label: item.net_id + " - " + item.first_name + " " + item.last_name + " (" + item.home_orgn_desc + ")",
            value: item.net_id
          }
        }));
      }
    });
  },
  minLength: 3,
  select: function (event, ui) {
    $(this).val(ui.item.value);
    $(this).trigger('blur');
    $(this).trigger('change');
  },
  change: function (event, ui) {
    if (typeof select_active_employee_net_id_input == 'function') {
      select_active_employee_net_id_input(this, this.value);
    }
  },
  open: function() {
      $( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
  },
  close: function() {
      $( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
  }

});

}

var employee_autocomplete_employee_found = Object.new;

function get_employee_from_id(id) {
  employee_autocomplete_employee_found = {};
  return($.ajax({
    url: "/employee-lookup/employee-basic/" + encodeURIComponent(id) + "/active" ,
    dataType: "json",
    delay: 1000,
    data: {
    },
    error: function(XMLHttpRequest, textStatus, errorThrown) {
          alert("Lookup error for active employees. Please confirm that the HR/Payroll data web services are running. (" + errorThrown + ")");
          employee_autocomplete_employee_found = {error: errorThrown};
    },
    success: function (data) {
      // expecting just one match.  Error if more
      switch (data.length) {
        case 1:
          employee_autocomplete_employee_found = data[0];
          break;
        case 0:
          employee_autocomplete_employee_found = {error: 'Employee could not be found using provided ID.'}
          break;
        default:
          employee_autocomplete_employee_found = {error: 'More than one match on id lookup.'}
      }
    }
  }));

}

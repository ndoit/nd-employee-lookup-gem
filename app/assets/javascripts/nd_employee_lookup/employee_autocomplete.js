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
          data: {
          },
          error: function(XMLHttpRequest, textStatus, errorThrown) {
            if (errorThrown != 'Not Found')
              alert('An error occurred while searching for employees.  Verify the HR/PY API is running [' + errorThrown +']');
            response([]);
          },
          success: function (data) {
            if(!data.length){
              var result = [
               {
               label: 'No matches found',
               value: ' '
               }
             ];
               response(result);
             }
             else{
               response( $.map(data, function( item) {
                  return {
                    label: item.net_id + " - " + item.first_name + " " + item.last_name + " (" + item.home_orgn_desc + ")",
                    value: item.net_id
                  }
               }));
            }
          }
        });

  },
  minLength: 3,
  delay: 300,
  select: function (event, ui) {
    if (ui.item.value.trim() == '') {
      event.preventDefault();
      return;
    }
    $(this).val(ui.item.value);
    $(this).trigger('change');
    $(this).trigger('blur');
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
    data: {
    },
    error: function(XMLHttpRequest, textStatus, errorThrown) {
      if (errorThrown != 'Not Found')
        alert('An error occurred while searching for employees.  Verify the HR/PY API is running [' + errorThrown +']');
      employee_autocomplete_employee_found = {error: errorThrown};
    },
    success: function (data) {
      switch (data.length) {
        case 1:
          employee_autocomplete_employee_found = data[0];
          break;
        case 0:
          employee_autocomplete_employee_found = {error: 'Employee could not be found using provided ID.'}
          break;
        default:
          var employee_found = false;
          for(i=0;i<data.length;i++) {
            if (data[i].net_id == id) {
              employee_autocomplete_employee_found = data[i];
              employee_found = true;
              break;
            }
          }
          if (!employee_found)
            employee_autocomplete_employee_found = {error: 'Employee could not be found using provided ID.'};
      }
    }
  }));

}

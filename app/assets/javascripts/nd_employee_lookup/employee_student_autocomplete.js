/* Add the class employee_student_id_input to your input field
 * Call employeeStudentLookup.set_employee_student_id_autocomplete in document ready
 * Select and change will call a function named:
 * select_employee_student_id_input(search_field, ndid) if it is available
 */

var employeeStudentLookup = (
  () => {

    var ajax_params_base = (search_term, error, success) => {
      return {
        url: "/employee-lookup/employee-student-basic/" + encodeURIComponent(search_term),
        dataType: "json",
        data: { },
        error: error,
        success: success
      }
    }

    var get_employee_student_from_id = (id) => {
      return $.ajax(
        employeeStudentLookup.ajax_params_base(id, errorFunction, successFunction)
      );

      function errorFunction(XMLHttpRequest, textStatus, errorThrown) {
        if (errorThrown != 'Not Found')
          alert('An error occurred while searching NDIDs.  ' +
            'Verify the HR/PY API is running [' + errorThrown + ']');
        get_employee_student_from_id_employee_student_found = {error: errorThrown};
      }

      function successFunction(data) {
        switch (data.length) {
          case 1:
            get_employee_student_from_id_employee_student_found = data[0];
            break;
          case 0:
            get_employee_student_from_id_employee_student_found = {
              error: 'Person could not be found using provided ID.'}
            break;
          default:
            var employee_student_found = false;
            for(i=0; i<data.length; i++) {
              if (data[i].ndid == id || data[i].net_id == id) {
                get_employee_student_from_id_employee_student_found = data[i];
                employee_student_found = true;
                break;
              }
            }
            if (!employee_student_found)
              get_employee_student_from_id_employee_student_found = {
                error: 'Person could not be found using provided ID.'};
        }
      }
    }

    var set_employee_student_id_autocomplete = (active = '') => {

      var lookup_employee_student = (request, response) => {
        var ajax_params =
          ajax_params_base( request.term,
            lookup_employee_student_error_function, lookup_employee_student_success_function)

        $.ajax(ajax_params);

        function lookup_employee_student_error_function(XMLHttpRequest, textStatus, errorThrown) {
          lookup_employee_student_error_base(XMLHttpRequest, textStatus, errorThrown, response)
        }
        function lookup_employee_student_success_function(data) {
          lookup_employee_student_success_base(data, response)
        }
      }

      function select_employee_student(event, ui) {
        if (ui.item.value.trim() == '') {
          event.preventDefault();
          return;
        }
        get_employee_student_from_id(ui.item.value);
        $(this).val(ui.item.value);
        $(this).trigger('change');
        $(this).trigger('blur');
      }
      function employee_student_input_change_function(event, ui) {
        if (typeof select_employee_student_id_input == 'function') {
          select_employee_student_id_input(this, this.value);
        }
      }

      $(".employee_student_id_input").autocomplete({
        source: lookup_employee_student,
        minLength: 3,
        delay: 300,
        autoFocus: true,
        select: select_employee_student,
        change: employee_student_input_change_function
      });

    }


    var lookup_employee_student_error_base =
      (XMLHttpRequest, textStatus, errorThrown, response) => {
        if (errorThrown != 'Not Found')
          alert('An error occurred while searching NDIDs.  ' +
            'Verify the HR/PY API is running [' + errorThrown + ']');
        response([]);
      }

    var lookup_employee_student_success_base =
      (data, response) => {
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
          response( $.map(data, format_employee_student_function));
        }
      }

    var format_employee_student_function = (item) => {
      var first_name = "";
      var middle_initial = "";
      var last_name = "";
      var employee_student_id = item.net_id;
      if(typeof item.first_name !== "undefined") {
        first_name = item.first_name
      }
      if(typeof item.last_name !== "undefined") {
        last_name = " " + item.last_name
      }
      if(typeof item.mi !== "undefined") {
        middle_initial = " " + item.mi
      }
      return {
        label: employee_student_id + " - " + first_name + middle_initial + last_name,
        value: item.net_id
      }
    }

    return {
      get_employee_student_from_id: get_employee_student_from_id,
      set_employee_student_id_autocomplete: set_employee_student_id_autocomplete,
      ajax_params_base: ajax_params_base,
    }

  }
)()

var get_employee_student_from_id_employee_student_found = Object.new;

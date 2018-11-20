/* Add the class person_id_input to your input field
 * Call personLookup.set_person_id_autocomplete in document ready
 * Select and change will call a function named:
 * select_person_id_input(search_field, ndid) if it is available
 */

var personLookup = (
  () => {

    var ajax_params_base = (search_term, error, success) => {
      return {
        url: "/employee-lookup/person-basic/" + encodeURIComponent(search_term),
        dataType: "json",
        data: { },
        error: error,
        success: success
      }
    }

    var get_person_from_id = (id) => {
      return $.ajax(
        personLookup.ajax_params_base(id, errorFunction, successFunction)
      );

      function errorFunction(XMLHttpRequest, textStatus, errorThrown) {
        if (errorThrown != 'Not Found')
          alert('An error occurred while searching NDIDs.  ' +
            'Verify the HR/PY API is running [' + errorThrown + ']');
        get_person_from_id_person_found = {error: errorThrown};
      }

      function successFunction(data) {
        switch (data.length) {
          case 1:
            get_person_from_id_person_found = data[0];
            break;
          case 0:
            get_person_from_id_person_found = {
              error: 'Person could not be found using provided ID.'}
            break;
          default:
            var person_found = false;
            for(i=0; i<data.length; i++) {
              if (data[i].ndid == id || data[i].net_id == id) {
                get_person_from_id_person_found = data[i];
                person_found = true;
                break;
              }
            }
            if (!person_found)
              get_person_from_id_person_found = {
                error: 'Person could not be found using provided ID.'};
        }
      }
    }

    var set_person_id_autocomplete = (active = '') => {

      var lookup_person = (request, response) => {
        var ajax_params =
          ajax_params_base( request.term,
            lookup_person_error_function, lookup_person_success_function)

        $.ajax(ajax_params);

        function lookup_person_error_function(XMLHttpRequest, textStatus, errorThrown) {
          lookup_person_error_base(XMLHttpRequest, textStatus, errorThrown, response)
        }
        function lookup_person_success_function(data) {
          lookup_person_success_base(data, response)
        }
      }

      function select_person(event, ui) {
        if (ui.item.value.trim() == '') {
          event.preventDefault();
          return;
        }
        get_person_from_id(ui.item.value);
        $(this).val(ui.item.value);
        $(this).trigger('change');
        $(this).trigger('blur');
      }
      function person_input_change_function(event, ui) {
        if (typeof select_person_id_input == 'function') {
          select_person_id_input(this, this.value);
        }
      }

      $(".person_id_input").autocomplete({
        source: lookup_person,
        minLength: 3,
        delay: 300,
        autoFocus: true,
        select: select_person,
        change: person_input_change_function
      });

    }


    var lookup_person_error_base =
      (XMLHttpRequest, textStatus, errorThrown, response) => {
        if (errorThrown != 'Not Found')
          alert('An error occurred while searching NDIDs.  ' +
            'Verify the HR/PY API is running [' + errorThrown + ']');
        response([]);
      }

    var lookup_person_success_base =
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
          response( $.map(data, format_person_function));
        }
      }

    var format_person_function = (item) => {
      var first_name = "";
      var middle_initial = "";
      var last_name = "";
      var pretty_person_id = item.person_id;
      if(typeof item.ndid !== "undefined") {
        pretty_person_id = item.ndid
      }
      if(typeof item.netid !== "undefined") {
        pretty_person_id = item.netid
      }
      if(typeof item.first_name !== "undefined") {
        first_name = item.first_name
      }
      if(typeof item.last_name !== "undefined") {
        last_name = " " + item.last_name
      }
      if(typeof item.middle_initial !== "undefined") {
        middle_initial = " " + item.middle_initial
      }
      return {
        label: pretty_person_id + " - " + first_name + middle_initial + last_name,
        value: item.person_id
      }
    }

    return {
      get_person_from_id: get_person_from_id,
      set_person_id_autocomplete: set_person_id_autocomplete,
      ajax_params_base: ajax_params_base,
    }

  }
)()

var get_person_from_id_person_found = Object.new;

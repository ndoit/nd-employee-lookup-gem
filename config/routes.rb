NdEmployeeLookup::Engine.routes.draw do
  get '/search' => 'employee_lookup#new'

  get 'employee' => 'employee_lookup#search'
  get 'employee/l/:last_name(/:first_name)' => 'employee_lookup#search', constraints: { :last_name => /[^\/]+/, :first_name => /[^\/]+/ }
  get 'employee/:status/l/:last_name(/:first_name)' => 'employee_lookup#search', constraints: { :last_name => /[^\/]+/, :first_name => /[^\/]+/ }
  get 'employee/:status/:search_string' => 'employee_lookup#search'
  get 'employee/:search_string' => 'employee_lookup#search'
end

NdEmployeeLookup::Engine.routes.draw do
  get '/search' => 'employee_lookup#new'

  get 'employee' => 'employee_lookup#search'
  get 'employee/l/:last_name(/:first_name)' => 'employee_lookup#search', constraints: { :last_name => /[^\/]+/, :first_name => /[^\/]+/ }
  get 'employee/:status/l/:last_name(/:first_name)' => 'employee_lookup#search', constraints: { :last_name => /[^\/]+/, :first_name => /[^\/]+/ }
  get 'employee/:status/:employee_id' => 'employee_lookup#search'
  get 'employee/:employee_id' => 'employee_lookup#search'
  get 'employee-basic/:search_string(/:status)' => 'employee_lookup#quick_search'

end

Rails.application.routes.draw do
  mount NdEmployeeLookup::Engine, at: '/employee-lookup'
end

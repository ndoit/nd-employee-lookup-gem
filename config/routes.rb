NdEmployeeLookup::Engine.routes.draw do
  get '/search' => 'employee_lookup#new'

  get 'employee' => 'employee_lookup#search'
  get 'employee/l/:last_name(/:first_name)' => 'employee_lookup#search', constraints: { :last_name => /[^\/]+/, :first_name => /[^\/]+/ }
  get 'employee/:status/l/:last_name(/:first_name)' => 'employee_lookup#search', constraints: { :last_name => /[^\/]+/, :first_name => /[^\/]+/ }
  get 'employee/:status/:employee_id' => 'employee_lookup#search'
  get 'employee/:employee_id' => 'employee_lookup#search'
  get 'employee-basic/:search_string(/:status)' => 'employee_lookup#quick_search'
  get 'employee-exact/:employee_id' => 'employee_lookup#find'

  get 'person-basic/:search_string' => 'person_lookup#quick_search'
  get 'person-exact/:person_id' => 'person_lookup#find'

  get 'employee-student-basic/:search_string' => 'employee_student_lookup#quick_search'
  get 'employee-student-exact/:person_id' => 'employee_student_lookup#find'

end

Rails.application.routes.draw do
  mount NdEmployeeLookup::Engine, at: '/employee-lookup'
end

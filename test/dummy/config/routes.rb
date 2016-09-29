Rails.application.routes.draw do
  mount NdEmployeeLookup::Engine => "/nd_employee_lookup"
end

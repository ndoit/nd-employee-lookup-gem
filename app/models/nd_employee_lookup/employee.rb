module NdEmployeeLookup
  class Employee < ::ActiveRecord::Base
    has_many :employee_jobs, class_name: 'NdJobLookup::EmployeeJob'
    accepts_nested_attributes_for :employee_jobs
  end
end

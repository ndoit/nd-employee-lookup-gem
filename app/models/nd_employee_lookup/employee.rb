module NdEmployeeLookup
  class Employee < ::ActiveRecord::Base
    # NdJobLookup:: module will monkey-patch these into Employee
    # has_many :employee_jobs
    # accepts_nested_attributes_for :employee_jobs
  end
end

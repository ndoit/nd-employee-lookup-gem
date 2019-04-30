module NdEmployeeLookup
  class Employee < ::ActiveRecord::Base
    has_many :employee_jobs, class_name: 'NdJobLookup::EmployeeJob'
    accepts_nested_attributes_for :employee_jobs

    def self.exact_lookup(employee_id, status = 'active-incnew')
      employee_prototype = HrpyEmployeePerson.
        search(
          status: status, employee_id: employee_id
      ).select do |e|
        e["net_id"] == employee_id.upcase ||
          e['nd_id'] == employee_id
      end.first.
      try(:except, 'active_primary_title', 'home_coas', 'last_day_worked')

      unless employee_prototype.nil?
        return Employee.new(
          employee_prototype
        )
      end
      nil
    end

    def name
      "#{first_name} #{last_name}"
    end
    def netid
      net_id
    end
    def ndid
      nd_id
    end

  end
end

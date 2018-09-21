require 'nd_employee_lookup/errors'

module NdEmployeeLookup
  class EmployeeStudentPerson
    def self.find(person_id)
      JsonParser.read(find_url(person_id))
    end

    def self.search(search_string)
      JsonParser.read(search_url(search_string))
    end

    def self.find_url(person_id)
      find_url = "#{ENV['PERSON_API_BASE']}/person/v1/employees_students/"
      find_url += person_id
    end

    def self.search_url(search_string)
      search_url = "#{ENV['PERSON_API_BASE']}/person/v1/employees_students/s/"
      search_url += URI.escape(search_string)
    end
  end
end

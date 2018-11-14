require 'nd_employee_lookup/errors'

module NdEmployeeLookup
  class Person
    def self.find(person_id)
      JsonParser.read(find_url(person_id))
    end

    def self.search(search_string)
      JsonParser.read(search_url(search_string))
    end

    def self.find_url(person_id)
      find_url = "#{ENV['PERSON_API_BASE']}/person/v1/basic/"
      find_url += person_id + "?api_key=" + ENV['PERSON_API_KEY']
    end

    def self.search_url(search_string)
      search_url = "#{ENV['PERSON_API_BASE']}/person/v1/basic/s/"
      search_url += URI.escape(search_string) + "?api_key=" + ENV['PERSON_API_KEY']
    end
  end
end

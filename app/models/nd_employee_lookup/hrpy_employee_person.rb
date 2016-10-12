module NdEmployeeLookup
  class InvalidLookup < StandardError; end
  class HrpyEmployeePerson # < ActiveRecord::Base
    attr_accessor :net_id, :last_name, :first_name, :nd_id
    attr_accessor :errors

    def self.find_by(*args)
      raise InvalidLookup if args[0].keys == [:first_name]
    end

    def save
    end

    def save!
    end

    def new_record?
      false
    end

    def update_attribute
    end

    def initialize(*args)
      #
    end
  end
end

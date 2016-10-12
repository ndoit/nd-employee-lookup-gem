module NdEmployeeLookup
  class InvalidLookup < StandardError; end
  class HrpyEmployeePerson # < ActiveRecord::Base
    attr_accessor :net_id, :last_name, :first_name, :nd_id
    attr_accessor :errors

    def self.find_by(*args)
      raise InvalidLookup if args[0].keys == [:first_name]
      search(args[0])
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

    private

    def self.search(params)
      clean_params = sanitize_params(params)
      url_open = open lookup_url_from_params(clean_params)
      search_results = JSON.parse(url_open.read)
      r = []
      if search_results.empty?
        r
      else
        search_results.each do |e|
          h = HrpyEmployeePerson.new
          h.first_name = e['first_name']
          h.last_name = e['last_name']
          h.net_id = e['net_id']
          h.nd_id = e['nd_id']
          r << h
        end
        r
      end
    end

    def self.sanitize_params(params)
      cparams = {}
      if params.key?(:status)
        if params[:status] == "active"
          cparams[:status] = "active"
        else
          raise InvalidParams
        end
      end
      if params.key?(:last_name)
        if params[:last_name].length <= 60
          cparams[:last_name] = params[:last_name]
        else
          raise InvalidParams
        end
      end
      if params.key?(:first_name)
        if params[:first_name].length <= 60
          cparams[:first_name] = params[:first_name]
        else
          raise InvalidParams
        end
      end
      if params.key?(:user_id)
        if params[:user_id] =~ /[a-zA-Z0-9]/
          cparams[:search_string] = params[:user_id]
        else
          raise InvalidParams
        end
      end
      return cparams
    rescue => e
      raise e
    end

    def self.lookup_url_from_params(clean_params)
      lookup_url = "#{ENV['HRPY_API_BASE']}/employee/v1"
      lookup_url += query_string(clean_params)
      lookup_url += "?api_key=#{ENV['HRPY_API_KEY']}"
    end

    def self.query_string(params)
      qs = ""
      if params.key?(:status)
        qs += "/" + params[:status]
      end

      if params.key?(:last_name)
        qs += "/l/" + URI.encode(params[:last_name])
      end
      if params.key?(:first_name)
        qs += "/" + URI.encode(params[:first_name])
      end
      if params.key?(:search_string)
        qs += "/" + URI.encode(params[:search_string])
      end
      qs
    end
  end
end

require 'open-uri'
require 'uri'
require 'json'

require "nd_employee_lookup/errors"

module NdEmployeeLookup
  class EmployeeLookupController < ApplicationController
    # skip_before_action :user_login

    protect_from_forgery with: :exception

    include Rails.application.routes.url_helpers

    def new
    end

    def search
      json = HrpyEmployeePerson.search(params)
      search_results = JSON.parse(json)
      if search_results.empty?
        render :json => JSON.parse('[{ "Employee": "None", "employee_title": "No matching records"}]')
      else
        render :json => search_results
      end

    rescue => e
      case e
      when NdEmployeeLookup::InvalidParams
        render :json => JSON.parse('[{ "Employee": "Error", "employee_title": "Invalid Parameters"}]')
      when OpenURI::HTTPError
        render :json => JSON.parse('[{ "Employee": "Error", "employee_title": "HRPY API server denied the API request"}]')
        # Does your HRPY_API_KEY exist and have the right permissions?
      when Errno::ENOENT
        render :json => JSON.parse('[{ "Employee": "Error", "employee_title": "HRPY API server endpoint refers to a file"}]')
        # Did you forget to set HRPY_API_BASE ?
      when Errno::ECONNREFUSED
        render :json => JSON.parse('[{ "Employee": "Error", "employee_title": "HRPY API server endpoint refused the connection"}]')
      when OpenSSL::SSL::SSLError
        render :json => JSON.parse('[{ "Employee": "Error", "employee_title": "Certificate verification error trying to reach the HRPY API"}]')
      when SocketError
        render :json => JSON.parse('[{ "Employee": "Error", "employee_title": "Socket error"}]')
      when URI::InvalidURIError
        render :json => JSON.parse('[{ "Employee": "Error", "employee_title": "Invalid URI"}]')
      else
        render :json => JSON.parse('[{ "Employee": "Error", "employee_title": "An unknown error has occurred"}]')

      end

    rescue SystemCallError => e
      if e === Errno::ECONNRESET
        render :json => JSON.parse('[{ "Employee": "Error", "Employee_title": "Server not available"}]')
      else
        raise e
      end
    end


      def quick_search
        json = HrpyEmployeePerson.quick_search(params)
        search_results = JSON.parse(json)
        render :json => search_results
      rescue => e
        case e.class.to_s
        when 'NdEmployeeLookup::InvalidParams'
            render :json => [{error: 'Not Found'}], :status => :not_found
        when 'OpenURI::HTTPError'
          response_status = e.io.status[0]
          if response_status == '404'
            render :json => [{error: 'Not Found'}], :status => :not_found
          else
            render :json => [{error: api_error_message(e)}], :status => :unprocessable_entity
          end
        else
          render :json => [{error: api_error_message(e)}], :status => :unprocessable_entity
        end
      end

      def api_error_message(e)
    	    return "Invalid Parameters" if e.class.to_s == 'InvalidParams'
    			return "HTTP Error" if e.class.to_s == 'OpenURI::HTTPError'
    			return "Socket Error" if e.class.to_s == 'SocketError'
    			return "Invalid URI" if e.class.to_s == 'URI::InvalidURIError'
    			return "Server not available" if e.class.to_s === 'Errno::ECONNRESET'
    			Rails::logger.error "API Error: #{e.message}"
    			return "Unknown Error"
      end



  end
end

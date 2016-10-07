require 'open-uri'
require 'uri'
require 'json'

class InvalidParams < StandardError
end

module NdEmployeeLookup
  class EmployeeLookupController < ApplicationController
    skip_before_filter :user_login

    protect_from_forgery with: :exception

    include NdEmployeeLookup::Engine.routes.url_helpers

    def new
    end

    def search
      begin

        clean_params = sanitize_params(params)
        lookup_url = "#{ENV['HRPY_API_BASE']}/employee/v1"
        lookup_url += query_string(clean_params)
        lookup_url += "?api_key=#{ENV['HRPY_API_KEY']}"

        url_open = open(lookup_url)
        search_results = JSON.parse(url_open.read)
        if search_results.empty?
          render :json => JSON.parse('[{ "Employee": "None", "employee_title": "No matching records"}]')
        else
          render :json => search_results
        end

      rescue => e
        case e
        when InvalidParams
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
    end

    private

    def sanitize_params(params)
      begin
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
        if params.key?(:search_string)
          if params[:search_string] =~ /[a-zA-Z0-9]/
            cparams[:search_string] = params[:search_string]
          else
            raise InvalidParams
          end
        end
        return cparams
      rescue => e
        raise e
      end
    end

    def query_string(params)
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

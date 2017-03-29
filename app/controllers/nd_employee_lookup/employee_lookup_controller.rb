require 'open-uri'
require 'uri'
require 'json'

require "#{Rails.root}/lib/errors.rb"

module NdEmployeeLookup
  class EmployeeLookupController < ApplicationController
    skip_before_filter :user_login

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
  end
end

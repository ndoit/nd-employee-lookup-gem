require "nd_employee_lookup/errors"

module NdEmployeeLookup
  class PersonLookupController < ApplicationController
    include ApiErrorMessage

    protect_from_forgery with: :exception

    include Rails.application.routes.url_helpers

    def find
      search_result = Person.find(params[:person_id])
      if search_result.present?
        render json: search_result
      else
        render json: { "Person" => "None", "error" => "No matching record"}, status: :not_found
      end
    end

    def quick_search
      search_results = Person.search(params[:search_string])
      if search_results.present?
        render json: search_results
      else
        render json: { "Person" => "None", "error" => "No matching record"}, status: :not_found
      end
    end
  end
end

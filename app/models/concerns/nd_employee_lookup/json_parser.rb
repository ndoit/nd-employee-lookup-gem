require 'net/http'

module NdEmployeeLookup
  module JsonParser
    extend ActiveSupport::Concern

    def read(url, use_ssl: true)
      uri = URI(url)
      http = ::Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = use_ssl
      response = check_for_nil_response_body(http.get(uri))
      json = response.body
      JSON.parse(json)
    end
    module_function :read

    # private
    def check_for_nil_response_body(response)
      if response.body.nil?
        error =
          response.error_type.
          new(error_message_from_response(response), response)
        raise error
      end
      response
    end

    def error_message_from_response(response)
      "#{response.code} #{response.message}"
    end

    module_function :check_for_nil_response_body, :error_message_from_response
  end
end


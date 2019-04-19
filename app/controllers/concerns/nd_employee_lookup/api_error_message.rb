module NdEmployeeLookup
  module ApiErrorMessage
    extend ActiveSupport::Concern

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

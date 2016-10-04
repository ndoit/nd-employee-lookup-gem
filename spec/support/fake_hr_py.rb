require 'sinatra/base'

class FakeHrPy < Sinatra::Base
  # get '/employee/v1/l/:last_name' do
  #   json_response 200, 'employees.json'
  # end

  get '/employee/v1/l/:last_name/:first_name' do
    lname = params['last_name']
    fname = params['first_name']

    if fname == "T"
      json_response 200, 'employees.json'
    elsif fname == "Teresa"
      json_response 200, 'employee.json'
    end
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
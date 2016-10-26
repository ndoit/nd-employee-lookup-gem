require 'sinatra/base'

class FakeHrPy < Sinatra::Base
  # get '/employee/v1/l/:last_name' do
  #   json_response 200, 'employees.json'
  # end

  get '/employee/v1/?:status?/l/:last_name/:first_name' do
    lname = params['last_name']
    fname = params['first_name']

    if /Teresa/i =~ fname && /Meyer/i =~ lname
      json_response 200, 'employee.json'
    elsif /T/i =~ fname && /Meyer/i =~ lname
      json_response 200, 'employees.json'
    end
  end

  get '/employee/v1/?:status?/l/:last_name' do
    lname = params['last_name']

    if /Meyer/i =~ lname
      json_response 200, 'employeeeeees.json'
    end
  end

  get '/employee/v1/?:status?/:search_string' do
    employee_id = params['search_string']

    if employee_id == 'tmeyer2'
      json_response 200, 'employee.json'
    elsif employee_id == 'tmeyer'
      json_response 200, 'employees.json'
    elsif employee_id == '900197659'
      json_response 200, 'jbracke3.json'
    end
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end

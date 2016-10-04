require 'support/fake_hr_py'

feature 'External request' do
  it 'queries HRPY API for a single employee' do
    uri = URI("#{ENV['HRPY_API_BASE']}/employee/v1/l/Meyer/Teresa")
    response = JSON.load(Net::HTTP.get(uri))
    expect(response.first['last_name']).to eq 'Meyer'
    expect(response.first['first_name']).to eq 'Teresa'
  end
  it 'queries HRPY API for two employees' do
    uri = URI("#{ENV['HRPY_API_BASE']}/employee/v1/l/Meyer/T")
    response = JSON.load(Net::HTTP.get(uri))
    expect(response.first['last_name']).to eq 'Meyer'
    expect(response.first['first_name']).to eq 'Teresa'
    n = response[1]
    expect(n['last_name']).to eq 'Meyers'
    expect(n['first_name']).to eq 'Thomas'
  end
end

require 'support/fake_hr_py'

feature 'External request' do
  it 'queries HRPY API for a single employee' do
    uri = URI("#{ENV['HRPY_API_BASE']}/employee/v1/l/Meyer/Teresa")
    response = JSON.load(Net::HTTP.get(uri))
    expect(response.first['login']).to eq 'joshuaclayton'
  end
  it 'queries HRPY API for two employees' do
    uri = URI("#{ENV['HRPY_API_BASE']}/employee/v1/l/Meyer")
    response = JSON.load(Net::HTTP.get(uri))
    expect(response.first['login']).to eq 'joshuaclayton'
  end
end

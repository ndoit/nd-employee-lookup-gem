feature 'External request' do
  it 'queries HRPY API for a single employee' do
    uri = URI("#{ENV['HRPY_API_BASE']}/employee/v1/l/Meyer/Teresa")
    response = Net::HTTP.get(uri)
    expect(response).to be_an_instance_of(String)
  end
  it 'queries HRPY API for two employees' do
    uri = URI("#{ENV['HRPY_API_BASE']}/employee/v1/l/Meyer")
    response = Net::HTTP.get(uri)
    expect(response).to be_an_instance_of(String)
  end
end

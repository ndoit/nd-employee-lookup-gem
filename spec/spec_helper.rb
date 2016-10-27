require 'support/fake_hr_py'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)
RSpec.configure do |config|
  config.before(:each) do
    hrpy_api_base = Regexp.escape(ENV['HRPY_API_BASE'])
    stub_request(:any, %r{#{hrpy_api_base}}).
      to_rack(FakeHrPy)
  end
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

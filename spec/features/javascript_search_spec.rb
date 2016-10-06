require 'support/fake_hr_py'

feature 'JavaScript search controller' do
  it 'should not have JavaScript errors', js: true do
    visit '/employee-lookup/search'
    expect(page).not_to have_errors
  end
  it 'should ...' do
    pending
  end
end

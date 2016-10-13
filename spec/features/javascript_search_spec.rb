feature 'JavaScript search controller' do
  ## FIXME: https://gist.github.com/gkop/1371962
  # (have_errors does not work with selenium-webdriver)
  ## FIXME: We should really check for JS errors after every JS test
  it 'should not have JavaScript errors', js: true do
    visit '/employee-lookup/search'
    expect(page).not_to have_errors
  end
  it 'should answer a specific query with a single result', js: true do
    visit '/employee-lookup/search'
    fill_in 'nd_employee_lookup_last_name', with: 'Meyer'
    fill_in 'nd_employee_lookup_first_name', with: 'Teresa'
    find('#b_nd_employee_lookup_find').click

    name = page.find 'span#employee_name'
    expect(name.text).to match(/^Meyer, Teresa$/)
  end
  it 'should answer a less specific query with a list', js: true do
    visit '/employee-lookup/search'
    fill_in 'nd_employee_lookup_last_name', with: 'Meyer'
    fill_in 'nd_employee_lookup_first_name', with: 'T'
    find('#b_nd_employee_lookup_find').click

    results = page.find 'div#nd_employee_lookup_select_employee_list'
    expect(results).to have_selector('.emp_sel_box', visible: true)
    expect(page.all('.emp_sel_box').count).to eq 2
  end
  it 'should return an exact match when NetID has an exact match', js: true do
    visit '/employee-lookup/search'
    fill_in 'nd_employee_lookup_net_id', with: 'tmeyer2'
    find('#b_nd_employee_lookup_find').click

    name = page.find 'span#employee_name'
    expect(name.text).to match(/^Meyer, Teresa$/)
  end
end

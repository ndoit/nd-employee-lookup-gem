require 'rails_helper'
require 'support/fake_hr_py'

describe "nd_employee_lookup/employee_lookup/new.html.erb" do
  it "renders the employee_search partial" do
    render
    expect(view).to render_template(:new)
    expect(view).to render_template(partial: "_employee_search")
  end
end

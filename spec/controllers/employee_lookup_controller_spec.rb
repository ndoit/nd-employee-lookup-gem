require 'spec_helper'

describe NdEmployeeLookup::EmployeeLookupController do
  describe 'GET #new' do
    it "renders the search form as a partial" do
      pending 'the form is currently delivered as a single-page application'
      expect(response).to render_template(partial: 'employee_search')
    end
  end
end

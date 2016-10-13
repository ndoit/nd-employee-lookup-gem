require 'rails_helper'
require 'support/fake_hr_py'

describe NdEmployeeLookup::EmployeeLookupController do
  render_views
  routes { NdEmployeeLookup::Engine.routes }

  describe 'GET #new' do
    it "renders the search form as a partial" do
      get :new
      pending 'the form is currently delivered as a single-page application'
      expect(response).to render_template(partial: '_employee_search')
    end
  end
end

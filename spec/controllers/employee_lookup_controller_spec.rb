require 'rails_helper'
require 'support/fake_hr_py'

describe NdEmployeeLookup::EmployeeLookupController do
  render_views
  routes { NdEmployeeLookup::Engine.routes }

  describe 'GET #new' do
    it "renders the search form as a partial" do
      get :new
      expect(response).to render_template(partial: '_search')
    end
  end
end

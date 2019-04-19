describe NdEmployeeLookup::EmployeeLookupController, type: :controller do
  render_views
  routes { NdEmployeeLookup::Engine.routes }

  describe 'GET #new' do
    it "renders the search form as a partial", broken: true do
      get :new
      expect(response).to render_template(partial: '_employee_search')
    end
  end
end

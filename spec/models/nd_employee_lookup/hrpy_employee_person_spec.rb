require 'support/fake_hr_py'

module NdEmployeeLookup
  RSpec.describe HrpyEmployeePerson, type: :model do
    it "rejects a search by only first name" do
      expect do
        HrpyEmployeePerson.find_by first_name: 'teresa'
      end.to raise_error(NdEmployeeLookup::InvalidLookup)
    end
  end
end

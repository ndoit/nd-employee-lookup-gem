require 'support/fake_hr_py'

module NdEmployeeLookup
  RSpec.describe HrpyEmployeePerson, type: :model do
    it "rejects a search by only first name" do
      expect do
        HrpyEmployeePerson.find_by first_name: 'teresa'
      end.to raise_error(NdEmployeeLookup::InvalidLookup)
    end

    it "finds a user by net_id" do
      res = HrpyEmployeePerson.find_by user_id: 'tmeyer2'
      expect(res.count).to eq 1
      expect(res.first).to be_instance_of(HrpyEmployeePerson)
      person = res.first
      expect(person.first_name).to eql "Teresa"
      expect(person.last_name).to eql "Meyer"
    end

    it "finds a user by nd_id" do
      res = HrpyEmployeePerson.find_by user_id: '900197659'
      expect(res.count).to eq 1
      expect(res.first).to be_instance_of(HrpyEmployeePerson)
      person = res.first
      expect(person.first_name).to eql "James"
      expect(person.last_name).to eql "Bracke"
    end

    it "finds users by last name and first name" do
      res = HrpyEmployeePerson.find_by last_name: 'meyer', first_name: 't'
      expect(res.count).to eq 2
      expect(res.first).to be_instance_of(HrpyEmployeePerson)
    end

    it "finds users by last name" do
      res = HrpyEmployeePerson.find_by last_name: 'meyer'
      expect(res.count).to be >= 10
      expect(res.first).to be_instance_of(HrpyEmployeePerson)
    end

    it "finds users by partial net_id" do
      res = HrpyEmployeePerson.find_by user_id: 'tmeyer'
      expect(res.count).to eq 2
      expect(res.first).to be_instance_of(HrpyEmployeePerson)
    end
  end
end

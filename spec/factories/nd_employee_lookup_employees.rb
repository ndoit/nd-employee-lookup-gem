FactoryGirl.define do
  factory :nd_employee_lookup_employee, class: 'NdEmployeeLookup::Employee' do
    net_id "MyText"
    nd_id "MyText"
    last_name "MyText"
    first_name "MyText"
    middle_init "MyText"
    primary_title "MyText"
    employee_status "MyText"
    home_orgn "MyText"
    home_orgn_desc "MyText"
    pidm 1
    ecls_code "MyText"
    last_paid_date "2016-12-31"
  end
end

class AddTermReasonToEmployee < ActiveRecord::Migration
  def change
    add_column :nd_employee_lookup_employees, :first_hire_date, :date
    add_column :nd_employee_lookup_employees, :term_reason_code, :string
    add_column :nd_employee_lookup_employees, :term_date, :date
    add_column :nd_employee_lookup_employees, :adjusted_service_date, :date
    add_column :nd_employee_lookup_employees, :seniority_date, :date
  end
end

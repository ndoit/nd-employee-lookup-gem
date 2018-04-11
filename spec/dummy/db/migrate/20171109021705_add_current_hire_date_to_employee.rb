class AddCurrentHireDateToEmployee < ActiveRecord::Migration
  def change
    add_column :nd_employee_lookup_employees, :current_hire_date, :date
  end
end

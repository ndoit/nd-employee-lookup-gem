class AddCurrentHireDateToEmployee < ActiveRecord::Migration[4.2]
  def change
    add_column :nd_employee_lookup_employees, :current_hire_date, :date
  end
end

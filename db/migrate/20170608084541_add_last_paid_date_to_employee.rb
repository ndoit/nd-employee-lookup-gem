class AddLastPaidDateToEmployee < ActiveRecord::Migration[4.2]
  def change
    add_column :nd_employee_lookup_employees, :last_paid_date, :datetime
  end
end

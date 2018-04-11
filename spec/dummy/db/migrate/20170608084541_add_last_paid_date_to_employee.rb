class AddLastPaidDateToEmployee < ActiveRecord::Migration
  def change
    add_column :nd_employee_lookup_employees, :last_paid_date, :datetime
  end
end

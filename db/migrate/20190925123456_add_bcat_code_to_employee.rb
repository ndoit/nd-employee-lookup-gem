class AddBcatCodeToEmployee < ActiveRecord::Migration[4.2]
  def change
    add_column :nd_employee_lookup_employees, :bcat_code, :string
  end
end

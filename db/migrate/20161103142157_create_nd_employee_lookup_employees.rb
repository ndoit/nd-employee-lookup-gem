class CreateNdEmployeeLookupEmployees < ActiveRecord::Migration
  def change
    create_table :nd_employee_lookup_employees do |t|
      t.text :net_id
      t.text :nd_id
      t.text :last_name
      t.text :first_name
      t.text :middle_init
      t.text :primary_title
      t.text :employee_status
      t.text :home_orgn
      t.text :home_orgn_desc
      t.integer :pidm
      t.text :ecls_code

      t.timestamps null: false
    end
  end
end

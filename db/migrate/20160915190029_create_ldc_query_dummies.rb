class CreateLdcQueryDummies < ActiveRecord::Migration
  def change
    create_table :ldc_query_dummies do |t|

      t.timestamps null: false
    end
  end
end

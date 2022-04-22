class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :fantasy_name
      t.string :customer_name
      t.string :tax_id
      t.boolean :status
      t.string :state_registration

      t.timestamps
    end
  end
end

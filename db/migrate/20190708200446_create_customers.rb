class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.integer :pay_id
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end

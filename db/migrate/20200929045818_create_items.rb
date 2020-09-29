class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.timestamps
      t.string :name, null: false
      t.text :detail, null: false
      t.integer :price, null: false
      t.integer :condition_id, null: false
      t.integer :delivery_fee_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :delivery_day_id, null: false
      t.references :brand, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: {to_table: :users}
      t.references :buyer, null: false, foreign_key: {to_table: :users}
    end
  end
end

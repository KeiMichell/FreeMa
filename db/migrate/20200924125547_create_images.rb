class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.timestamps
      t.string :image, null: false
      t.references :item, null: false, foreign_key: true
    end
  end
end

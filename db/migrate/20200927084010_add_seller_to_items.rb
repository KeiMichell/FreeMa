class AddSellerToItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :items, :status, null: false, foreign_key: {to_table: :users}
  end
end

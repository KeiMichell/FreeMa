class Item < ApplicationRecord
  has_many :images
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  belongs_to_active_hash :conditon
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :delivery_day
  belongs_to_active_hash :prefecture
end

class Item < ApplicationRecord
  has_many :images
  belongs_to :seller, class_name: 'User', foreign_key: 'seller_id'
  belongs_to :buyer, class_name: 'User', optional: true, foreign_key: 'buyer_id'
  belongs_to :category
  belongs_to :brand
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :delivery_day
  belongs_to_active_hash :prefecture
end

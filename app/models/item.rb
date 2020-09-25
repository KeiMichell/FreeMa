class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :images
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :delivery_day
  belongs_to_active_hash :prefecture
end

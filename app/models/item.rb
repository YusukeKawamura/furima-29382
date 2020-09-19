class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :ship_method
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :ship_date
  belongs_to :user
end

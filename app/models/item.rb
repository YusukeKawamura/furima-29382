class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :ship_method
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :ship_date
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image, :name, :description, :category, :condition, :ship_method, :prefecture, :ship_date
    validates :price, numericality: { only_integer: true,
                                      greater_than_or_equal_to: 300,
                                      less_than_or_equal_to: 9_999_999 }
  end

  validates :category_id, :condition_id, :ship_method_id, :prefecture_id, :ship_date_id,
            numericality: { other_than: 1 }
end

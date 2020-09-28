class OrderAddress
  include ActiveModel::Model
  attr_accessor :postcode, :prefecture_id, :municipality, :street, :apartment, :tel, :token, :user_id, :item_id

  with_options presence: true do
    validates :token
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :municipality, :street
    validates :tel, format: { with: /\A[0-9]+\z/ }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      postcode: postcode, prefecture_id: prefecture_id, municipality: municipality,
      street: street, apartment: apartment, tel: tel, order_id: order.id
    )
  end
end

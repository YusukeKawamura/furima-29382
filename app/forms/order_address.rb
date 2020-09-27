class OrderAddress
  include ActiveModel::Model
  attr_accessor :postcode, :prefecture_id, :municipality, :street, :apartment, :tel, :token, :user_id, :item_id

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      postcode: postcode, prefecture_id: prefecture_id, municipality: municipality,
      street: street, apartment: apartment, tel: tel, order_id: order.id
    )
  end
end

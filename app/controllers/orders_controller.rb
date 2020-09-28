class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item_buyable_user

  def index
    @order = OrderAddress.new
  end

  def create
    @order = OrderAddress.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(
      :postcode, :prefecture_id, :municipality,
      :street, :apartment, :tel, :token
    ).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def find_item_buyable_user
    @item = Item.find_by(id: params[:item_id])
    redirect_to root_path if current_user.id == @item.user.id
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end

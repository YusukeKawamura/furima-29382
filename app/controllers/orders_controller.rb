class OrdersController < ApplicationController
  def index
    @item = Item.find_by(id: params[:item_id])
    @order = OrderAddress.new
  end

  def create
    @item = Item.find_by(id: params[:item_id])
    @order = OrderAddress.new(order_params)
    if @order.valid?
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
      :street, :apartment, :tel
    ).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end

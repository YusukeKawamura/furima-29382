class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :current_only, only: [:edit, :update]

  def index
    @items = Item.includes(:user)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy if (current_user == item.user) && user_signed_in?
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id,
      :ship_method_id, :prefecture_id, :ship_date_id, :price, :image
    ).merge(user_id: current_user.id)
  end

  def current_only
    @item = Item.find(params[:id])
    redirect_to root_path if (current_user != @item.user) || current_user.nil?
  end
end

class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :current_only, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order(id: 'DESC').includes(:user)
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
    @comments = Comment.where(item_id: @item.id)
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
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
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
    redirect_to root_path if !user_signed_in? || (current_user.id != @item.user.id)
  end
end

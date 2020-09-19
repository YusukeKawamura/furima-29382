class ItemsController < ApplicationController
  before_action :authenticate_user!
  def new
    @item = Item.new
  end
end

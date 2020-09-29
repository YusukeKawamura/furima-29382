class CommentsController < ApplicationController
  def new
    @comments = Comment.all.includes(:user, :item)
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comments_params)
  end

  private

  def comments_params
    params.require(:item).permit(:content).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end

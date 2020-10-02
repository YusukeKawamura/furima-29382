class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @item = Item.find_by(id: params[:item_id])
    @comment = Comment.new(comment_params)
    ActionCable.server.broadcast 'comment_channel', content: @comment if @comment.save
  end

  private

  def comment_params
    params.permit(:content).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end

class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    ActionCable.server.broadcast 'comment_channel', content: @mcomment if @comment.save
  end

  private

  def comment_params
    params.require(:item).permit(:content).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end

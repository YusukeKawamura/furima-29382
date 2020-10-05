class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @item = Item.find_by(id: params[:item_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', content: @comment,
                                                      nickname: @comment.user.nickname,
                                                      user_id: @comment.user.id,
                                                      item_id: @comment.item.user.id,
                                                      comment_id: @comment.id
    end
  end

  def destroy
    @item = Item.find_by(id: params[:item_id])
    @comment = Comment.find(params[:id])
    render 'items/destroy.js.erb' if @comment.destroy
  end

  private

  def comment_params
    params.permit(:content).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end

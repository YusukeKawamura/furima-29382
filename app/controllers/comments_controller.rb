class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @item = Item.find_by(id: params[:item_id])
    @comment = Comment.new(comment_params)
    @comments = Comment.where(item_id: @item.id)
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', content: @comment,
                                                      nickname: @comment.user.nickname,
                                                      user_id: @comment.user.id,
                                                      item_user_id: @comment.item.user.id,
                                                      item_id: @item.id,
                                                      comment_id: @comment.id,
                                                      comments_size: @comments.ids.size
    end
  end

  def destroy
    @item = Item.find_by(id: params[:item_id])
    @comment = Comment.find(params[:id])
    @comments = Comment.where(item_id: @item.id)
    render 'items/destroy.js.erb' if @comment.destroy
  end

  private

  def comment_params
    params.permit(:content).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end

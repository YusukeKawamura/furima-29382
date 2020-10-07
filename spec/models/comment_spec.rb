require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメント投稿' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    describe 'コメント投稿ができるとき' do
      it 'コメントが記載されていれば投稿できる' do
        expect(@comment).to be_valid
      end
    end

    describe 'コメント投稿ができないとき' do
      it 'コメントが空では投稿できない' do
        @comment.content = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Content can't be blank")
      end

      it 'ユーザーに紐付いていなければ投稿できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end

      it '商品に紐付いていなければ投稿できない' do
        @comment.item = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Item must exist')
      end
    end
  end
end

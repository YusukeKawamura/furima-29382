require 'rails_helper'

RSpec.describe '商品出品' do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品ができるとき' do
    it '全ての事項が漏れなく記載されていれば出品できる' do
      expect(@item).to be_valid
    end
  end

  describe '商品出品ができないとき' do
    describe '商品情報に不備があるとき' do
      describe '画像関連' do
        it '画像が添付されていないと出品できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
      end

      describe '商品名関連' do
        it '商品名が空では出品できない' do
          @item.name = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end
      end

      describe '商品説明関連' do
        it '商品説明が空では出品できない' do
          @item.description = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Description can't be blank")
        end
      end

      describe 'ドロップボックス関連' do
        it 'カテゴリーが選択されていないと出品できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Category must be other than 1')
        end
        it '商品の状態が選択されていないと出品できない' do
          @item.condition_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Condition must be other than 1')
        end
        it '配送料の負担が選択されていないと出品できない' do
          @item.ship_method_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Ship method must be other than 1')
        end
        it '発送元の地域が選択されていないと出品できない' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
        end
        it '発送までの日数が選択されていないと出品できない' do
          @item.ship_date_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Ship date must be other than 1')
        end
      end

      describe '価格関連' do
        it '金額が空では出品できない' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end
        it '金額が300円未満では出品できない' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
        end
        it '金額が1千万円以上では出品できない' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
        end
        it '金額が小数では出品できない' do
          @item.price = 1234.56
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be an integer')
        end
        it '金額が半角数字以外では出品できない' do
          @item.price = 'abcdef'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is not a number')
        end
      end
    end

    describe 'ユーザー関連に不備があるとき' do
      it 'ユーザーが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end

require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入' do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    describe '商品購入ができるとき' do
      it '全ての事項が漏れなく記載されていれば購入できる' do
        expect(@order_address).to be_valid
      end
    end

    describe '商品購入ができないとき' do
      describe 'カード情報に不備があるとき' do
        it 'トークンが生成去れなければ商品購入ができない' do
          @order_address.token = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Token can't be blank")
        end
      end
    end

    describe '配送先情報に不備があるとき' do
      describe '郵便番号関連' do
        it '郵便番号が空では商品購入ができない' do
          @order_address.postcode = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Postcode can't be blank")
        end
        it '郵便番号が3桁-4桁以外の形式では商品購入ができない' do
          @order_address.postcode = '1234-567'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Postcode is invalid')
        end
      end

      describe '都道府県関連' do
        it '都道府県が選択されていないと商品購入ができない' do
          @order_address.prefecture_id = 1
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
        end
      end

      describe '市区町村関連' do
        it '市区町村が空では商品購入ができない' do
          @order_address.municipality = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Municipality can't be blank")
        end
      end

      describe '番地関連' do
        it '番地が空では商品購入ができない' do
          @order_address.street = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Street can't be blank")
        end
      end

      describe '建物名関連' do
        it '建物名は空でも商品購入ができる' do
          @order_address.apartment = nil
          expect(@order_address).to be_valid
        end
      end

      describe '電話番号関連' do
        it '電話番号が空では商品購入ができない' do
          @order_address.tel = nil
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include("Tel can't be blank")
        end
        it '電話番号に半角数字以外が含まれていると商品購入ができない' do
          @order_address.tel = '12-3456-789'
          @order_address.valid?
          expect(@order_address.errors.full_messages).to include('Tel is invalid')
        end
      end
    end
  end
end

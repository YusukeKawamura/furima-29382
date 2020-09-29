require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe '新規登録ができるとき' do
      it '全ての事項が漏れなく記載されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    describe '新規登録ができないとき' do
      describe 'ユーザー情報に不備があるとき' do
        describe 'ニックネーム関連' do
          it 'ニックネームが空では登録できない' do
            @user.nickname = nil
            @user.valid?
            expect(@user.errors.full_messages).to include("Nickname can't be blank")
          end
        end

        describe 'メールアドレス関連' do
          it 'メールアドレスが空では登録できない' do
            @user.email = nil
            @user.valid?
            expect(@user.errors.full_messages).to include("Email can't be blank")
          end
          it '重複したメールアドレスでは登録できない' do
            @user.save
            another_user = FactoryBot.build(:user, email: @user.email)
            another_user.valid?
            expect(another_user.errors.full_messages).to include('Email has already been taken')
          end
          it 'メールアドレスに@がなければ登録できない' do
            @user.email = 'abcabc.gmail.com'
            @user.valid?
            expect(@user.errors.full_messages).to include('Email is invalid')
          end
        end

        describe 'パスワード関連' do
          it 'パスワードが空では登録できない' do
            @user.password = nil
            @user.valid?
            expect(@user.errors.full_messages).to include("Password can't be blank")
          end
          it 'パスワードが存在しても、パスワード（確認）が空では登録できない' do
            @user.password_confirmation = ''
            @user.valid?
            expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
          end
          it 'パスワードとパスワード（確認）が一致しなければ登録できない' do
            @user.password_confirmation = 'abc123'
            @user.valid?
            expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
          end
          it 'パスワードは6文字以上かつ英字と数字が両方含まれていれば登録できる' do
            @user.password = 'abc123'
            @user.password_confirmation = 'abc123'
            expect(@user).to be_valid
          end
          it '英字と数字が両方含まれていても、パスワードが5文字以下では登録できない' do
            @user.password = 'ab123'
            @user.password_confirmation = 'ab123'
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
          end
          it '6文字以上でも、パスワードが英字のみでは登録できない' do
            @user.password = 'abcabc'
            @user.password_confirmation = 'abcabc'
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is invalid')
          end
          it '6文字以上でも、パスワードが数字のみでは登録できない' do
            @user.password = '123456'
            @user.password_confirmation = '123456'
            @user.valid?
            expect(@user.errors.full_messages).to include('Password is invalid')
          end
        end
      end

      describe '本人情報確認に不備があるとき' do
        describe '氏名関連' do
          it '苗字が空では登録できない' do
            @user.family_name = nil
            @user.valid?
            expect(@user.errors.full_messages).to include("Family name can't be blank")
          end
          it '名前が空では登録できない' do
            @user.first_name = nil
            @user.valid?
            expect(@user.errors.full_messages).to include("First name can't be blank")
          end
          it '苗字・名前ともに、漢字・全角かな・全角カナの登録ができる' do
            @user.family_name = '一ぁァ'
            @user.first_name = 'んン龥'
            expect(@user).to be_valid
          end
          it '苗字に半角ｶﾅが含まれていると登録できない' do
            @user.family_name = 'ｧﾝ'
            @user.valid?
            expect(@user.errors.full_messages).to include('Family name is invalid')
          end
          it '名前に半角ｶﾅが含まれていると登録できない' do
            @user.first_name = 'ｧﾝ'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name is invalid')
          end
          it '苗字に半角英字が含まれていると登録できない' do
            @user.family_name = 'aZ'
            @user.valid?
            expect(@user.errors.full_messages).to include('Family name is invalid')
          end
          it '名前に半角英字が含まれていると登録できない' do
            @user.first_name = 'aZ'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name is invalid')
          end
          it '苗字に全角英字が含まれていると登録できない' do
            @user.family_name = 'ａＺ'
            @user.valid?
            expect(@user.errors.full_messages).to include('Family name is invalid')
          end
          it '名前に全角英字が含まれていると登録できない' do
            @user.first_name = 'ａＺ'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name is invalid')
          end
          it '苗字に記号が含まれていると登録できない' do
            @user.family_name = ' ~'
            @user.valid?
            expect(@user.errors.full_messages).to include('Family name is invalid')
          end
          it '名前に記号が含まれていると登録できない' do
            @user.first_name = ' ~'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name is invalid')
          end
        end

        describe 'フリガナ関連' do
          it '苗字(カナ)が空では登録できない' do
            @user.family_name_kana = nil
            @user.valid?
            expect(@user.errors.full_messages).to include("Family name kana can't be blank")
          end
          it '名前(カナ)が空では登録できない' do
            @user.first_name_kana = nil
            @user.valid?
            expect(@user.errors.full_messages).to include("First name kana can't be blank")
          end
          it '苗字(カナ)・名前(カナ)ともに、全角カナの登録ができる' do
            @user.family_name_kana = 'ァ'
            @user.first_name_kana = 'ン'
            expect(@user).to be_valid
          end
          it '苗字(カナ)に全角かなが含まれていると登録できない' do
            @user.family_name_kana = 'ぁん'
            @user.valid?
            expect(@user.errors.full_messages).to include('Family name kana is invalid')
          end
          it '名前(カナ)に全角かなが含まれていると登録できない' do
            @user.first_name_kana = 'ぁん'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name kana is invalid')
          end
          it '苗字(カナ)に漢字が含まれていると登録できない' do
            @user.family_name_kana = '一龥'
            @user.valid?
            expect(@user.errors.full_messages).to include('Family name kana is invalid')
          end
          it '名前(カナ)に漢字が含まれていると登録できない' do
            @user.first_name_kana = '一龥'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name kana is invalid')
          end
          it '苗字(カナ)に半角ｶﾅが含まれていると登録できない' do
            @user.family_name_kana = 'ｧﾝ'
            @user.valid?
            expect(@user.errors.full_messages).to include('Family name kana is invalid')
          end
          it '名前(カナ)に半角ｶﾅが含まれていると登録できない' do
            @user.first_name_kana = 'ｧﾝ'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name kana is invalid')
          end
          it '苗字(カナ)に半角英字が含まれていると登録できない' do
            @user.family_name_kana = 'aZ'
            @user.valid?
            expect(@user.errors.full_messages).to include('Family name kana is invalid')
          end
          it '名前(カナ)に半角英字が含まれていると登録できない' do
            @user.first_name_kana = 'aZ'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name kana is invalid')
          end
          it '苗字(カナ)に全角英字が含まれていると登録できない' do
            @user.family_name_kana = 'ａＺ'
            @user.valid?
            expect(@user.errors.full_messages).to include('Family name kana is invalid')
          end
          it '名前(カナ)に全角英字が含まれていると登録できない' do
            @user.first_name_kana = 'ａＺ'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name kana is invalid')
          end
          it '苗字(カナ)に記号が含まれていると登録できない' do
            @user.family_name_kana = ' ~'
            @user.valid?
            expect(@user.errors.full_messages).to include('Family name kana is invalid')
          end
          it '名前(カナ)に記号が含まれていると登録できない' do
            @user.first_name_kana = ' ~'
            @user.valid?
            expect(@user.errors.full_messages).to include('First name kana is invalid')
          end
        end

        describe '生年月日関連' do
          it '生年月日が空では登録できない' do
            @user.birth_day = nil
            @user.valid?
            expect(@user.errors.full_messages).to include("Birth day can't be blank")
          end
        end
      end
    end
  end
end

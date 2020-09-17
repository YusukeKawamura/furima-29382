class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :family_name, :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
    validates :family_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :birth_day
  end
end

class Renter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable
         :token_authenticatable
    has_many :rentedlists,dependent: :destroy
    has_many :wishlists,dependent: :destroy
    has_many :approaches, dependent: :destroy

validates :password, 
                format: { with: /\A(?=.*\d)(?=.*[A-Z])(?=.*\W)[^ ]{7,}\z/,
                          message: 'should have more than 7 characters including 1 uppercase letter, 1 number, 1 special character'
                        }
    
    
end

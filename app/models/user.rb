class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates_confirmation_of :password
    has_secure_password
    has_many :categories, dependent: :destroy
    has_many :tasks, through: :categories

    validates :firstname, presence:true,
                length: {minimum: 2, maximum: 26}
    validates :lastname, presence:true,
                length: {minimum: 2, maximum: 26}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
                length: {maximum: 105}, 
                uniqueness: {case_sensitive: false},
                format: { with: VALID_EMAIL_REGEX}



end

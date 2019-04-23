class User < ApplicationRecord
    has_secure_password
    
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :nullify

    validates :email, presence: true, uniqueness: { case_sensitive: false}, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i\
    # validates :password, presence: true, length: { minimum:6 }
end

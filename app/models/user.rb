class User < ApplicationRecord
    has_secure_password
    
    validates :email, presence: true, uniqueness: { case_sensitive: false}, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i\
end

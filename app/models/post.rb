class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    
    validates :title, presence: {message: "Must exist"}, uniqueness: true
    validates :body, presence: {message: 'Must exist'}, length: {minimum: 50}

end

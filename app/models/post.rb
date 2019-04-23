class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :user
    
    validates :title, presence: {message: "Must exist"}, uniqueness: true
    validates :body, presence: {message: 'Must exist'}, length: {minimum: 50}

end

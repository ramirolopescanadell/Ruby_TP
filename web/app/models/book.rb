class Book < ApplicationRecord
  has_many :note
  belongs_to :user
  validates :name, uniqueness: true, null:false 
  scope :books_per_user, -> (user_id){ where("user_id == ?",user_id )} 
end

class Book < ApplicationRecord
  has_many :note, dependent: :delete_all
  belongs_to :user
  
  validates :name, null:false 
  validates_uniqueness_of :name, scope: :user_id

  scope :books_per_user, -> (user_id){ where("user_id == ?",user_id )} 
  
  def empty
  	Note.empty(self.id)
  end
end

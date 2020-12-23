class Book < ApplicationRecord
  has_many :note
  belongs_to :user
end

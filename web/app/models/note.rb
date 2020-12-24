class Note < ApplicationRecord
	belongs_to :book

	validates :name, null:false 
  	validates_uniqueness_of :name, scope: :book_id
	
	scope :notes_per_book, -> (book_id){where("book_id == ?", book_id)}
	scope :empty, -> (book_id){where("book_id == ?", book_id).delete_all}
end

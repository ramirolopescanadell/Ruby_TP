class Note < ApplicationRecord
	belongs_to :book

	validates :name, null:false 
  	validates_uniqueness_of :name, scope: :book_id
	validates_length_of :name, maximum: 50, message: "- The name of the note must have a maximum of 30 characters"

	scope :notes_per_book, -> (book_id){where("book_id == ?", book_id)}
	scope :notes_per_user, -> (user_id) {joins(:book).where("user_id == ?", user_id).select("notes.*, books.name as book_name")}
	scope :empty, -> (book_id){where("book_id == ?", book_id).delete_all}
end

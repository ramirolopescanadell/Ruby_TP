require 'redcarpet'
class Note < ApplicationRecord
	belongs_to :book

	validates :name, null:false 
  	validates_uniqueness_of :name, scope: :book_id
	
	scope :notes_per_book, -> (book_id){where("book_id == ?", book_id)}
	scope :notes_per_user, -> (user_id) {joins(:book).where("user_id == ?", user_id).select("notes.*, books.name as book_name")}
	scope :empty, -> (book_id){where("book_id == ?", book_id).delete_all}

	def format 
    	markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    	markdown.render( self.content )
  	end

end

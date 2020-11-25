module RN
	module Models
		class Export


			def self.export_note(title, book)
				note = RN::Models::Note.new(title, book)
				note.export 
			end

			def self.export_book(book_name)
				RN::Models::Note.list(book_name).each {|note| export_note(note.split("/")[1], book_name) }
			end

			def self.export_all
				(RN::Models::Book.list).each {|book| export_book(book) } 		
			end
		end
	end
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..5).each do |i|
	user = User.create! name: "name#{i}", email: "email#{i}@hotmail.com",password: "password#{i}"
	
	(1..5).each do |b|
		book = user.books.create! name: "Book#{b}_user#{i}"

		(1..5).each do |n|
			book.note.create! name: "Note#{n}_book#{b}_user#{i}", content: "Esta nota con ID #{n} 
			pertenece al libro Book#{b}_user#{i} el cual pertence al usuario email#{i}@hotmail.com"
		end
	end
end	
require 'tty-editor'
require 'redcarpet'

module RN
	module Models
		class Note
			extend RN::Models::Validator
			
			attr_accessor :title, :book

			def initialize(title,  book=nil)
				self.title = title
				self.book = book || "global"
			end

			def create_path(book, title)
				return "#{Validator.my_rns}/#{book}/#{title}.rn"
			end

			def create_path_export(book, title)
				return "#{Validator.my_exports}/#{book}/#{title}.html"
			end

			def validate
				Validator.validate_name(title)
			end

			def create()
				path = create_path(book,title)
				
				if( File.exist?(path))
					"La nota con nombre '#{title}' ya exista, elija otro nombre"
				else
					TTY::Editor.open(path)
					"creando nota con nombre '#{title}' en libro '#{book}'"
				end 
			end

			def delete()
				path = create_path(book,title)

				if( File.exist?(path))
					File.delete(path)
					"Eliminando la nota con nombre '#{title}' en libro '#{book}'"
				else
					"La nota con nombre '#{title}' en el libro '#{book}' no existe"
				end 
			end

			def edit ()
				path = create_path(book,title)
				
				if( File.exist?(path))
					"Editando nota con nombre '#{title}'"
					TTY::Editor.open(path)
				else
					"No existe una nota llamada '#{title}' en el libro '#{book}'"
				end 
			end
			
			def retitle(new_title)

				old_path = self.create_path(book,title)

				if(File.exist?(old_path))
					#Si el titulo posee barras o astericos retorna error.
					return "El nombre posee caracteres inválidos" if Validator.validate_name(new_title)

					new_path = self.create_path(book,new_title)
					if( File.exist?(new_path))
						"La nota con nombre '#{new_title}' ya exista, elija otro nombre"
					else
						File.rename(old_path, new_path)
						"La nota '#{title}' ahora se llama '#{new_title}'"
					end
				else
					"La nota '#{title}' no existe"
				end
			end

			def self.list(book)
				path_length = ((Validator.my_rns).length) + 1
				notes = Dir.glob("#{Validator.my_rns}/#{book}**/*").map {|note| 
					note[path_length..-1].gsub(".rn","") 
				}		
			end

			def show()
				path = self.create_path(book,title)
				
				if(File.exist?(path))
					File.read(path)
				else
					"La nota '#{title}' no existe en el libro '#{book}'"
				end				
			end

			def export
				path = self.create_path(book,title)
				
				if(File.exist?(path))
					markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
					result = markdown.render( File.read(path) )
					path_export = self.create_path_export(book, title)
					begin
						File.write(path_export, result)
						"Exportando la nota '#{title}' del libro '#{book}'"
					rescue Errno::ENOENT
						FileUtils.mkdir_p("#{Validator.my_exports}/#{book}")
						retry
					end
				else
					"La nota '#{title}' no existe en el libro '#{book}'"
				end	
			end
		end
	end
end

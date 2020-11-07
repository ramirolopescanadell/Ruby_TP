require 'tty-editor'
require 'colorputs'

module RN
	module Models
		class Note
			extend RN::Models::Validator
			private
			def self.create_path(book, title)
				return "#{RN.my_rns}/#{book}/#{title}.rn"
			end

			def self.create(title, **options)
				#Si no llegó libro por parametro entonces uso el global
				book = options[:book].nil? ? "global" : options[:book]

		        #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
		        return warn "El libro '#{book}' no existe " unless File.directory?("#{RN.my_rns}/#{book}")
		          
		        #Si el titulo posee barras o astericos retorna error.
		        return warn "El nombre posee caracteres inválidos" if Validator.validate_name(title)

		        path = self.create_path(book,title)
		        if( File.exist?(path))
		          warn "La nota con nombre '#{title}' ya exista, elija otro nombre"
		        else
		          warn "creando nota con nombre '#{title}' en libro '#{book}'"
		          TTY::Editor.open(path)
		        end 
		      end

		      def self.delete(title, **options)
		      	#Si no llegó libro por parametro entonces uso el global
		        book = options[:book].nil? ? "global" : options[:book]

		        #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
		        return warn "El libro '#{book}' no existe " unless File.directory?("#{RN.my_rns}/#{book}")
		          
		        path = self.create_path(book,title)
		        if( File.exist?(path))
		           warn "Eliminando la nota con nombre '#{title}' en libro '#{book}'"
		           File.delete(path)
		        else
		           warn "La nota con nombre '#{title}' en el libro '#{book}' no existe"
		        end 
		      end

		      def self.edit (title, **options)
				#Si no llegó libro por parametro entonces uso el global
				book = options[:book].nil? ? "global" : options[:book]

				#Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
				return warn "El libro '#{book}' no existe " unless File.directory?("#{RN.my_rns}/#{book}")
				path = self.create_path(book,title)
				
				if( File.exist?(path))
					warn "Editando nota con nombre '#{title}'"
					TTY::Editor.open(path)
				else
					warn "No existe una nota llamada '#{title}' en el libro '#{book}'"
				end 
		end
			
			def self.retitle(old_title, new_title, **options)
			  #Si no llegó libro por parametro entonces uso el global
	          book = options[:book].nil? ? "global" : options[:book]

	          #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
	          return warn "El libro '#{book}' no existe " unless File.directory?("#{RN.my_rns}/#{book}")

	          old_path = self.create_path(book,old_title)
	          
	          if(File.exist?(old_path))
		        #Si el titulo posee barras o astericos retorna error.
		        return warn "El nombre posee caracteres inválidos" if Validator.validate_name(new_title)

	            new_path = self.create_path(book,new_title)
	            if( File.exist?(new_path))
	              warn "La nota con nombre '#{new_title}' ya exista, elija otro nombre"
	            else
	              warn "La nota '#{old_title}' ahora se llama '#{new_title}'"
	              File.rename(old_path, new_path)
	            end
	          else
	            warn "La nota '#{old_title}' no existe"
	          end
			end

			def self.list(**options)
	          book = options[:global] ? "global" : options[:book] 
	          path_length = ((RN.my_rns).length) + 1
	          puts "Listando notas:"
	          notes = Dir.glob("#{RN.my_rns}/#{book}**/*").map {|note| 
	            note[path_length..-1].gsub(".rn"," ") 
	          }
	          notes.each{|note| puts note ,(note.include?("/") ? :cyan : :red)}			
			end

			def self.show(title, **options)
				#Si no llegó libro por parametro entonces uso el global
				book = options[:book].nil? ? "global" : options[:book]
				
				#Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
				return warn "El libro '#{book}' no existe " unless File.directory?("#{RN.my_rns}/#{book}")
				
				path = self.create_path(book,title)
				
				if(File.exist?(path))
				  puts File.read(path)
				else
				  warn "La nota '#{title}' no existe"
				end				
			end
		end
	end
end

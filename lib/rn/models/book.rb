require 'fileutils'
module RN
	module Models
		class Book
			extend RN::Models::Validator

			attr_accessor :name

			def initialize(name)
      			self.name = name
    		end

			def create_path(book)
				return "#{Validator.my_rns}/#{book}"
			end

			def exist?()
				File.directory?("#{Validator.my_rns}/#{name}")
			end
			
			def create()
			    #Si el titulo posee barras o astericos retorna error.
			    raise "El nombre posee caracteres inválidos" if Validator.validate_name(name)
				Dir.mkdir(create_path(name))
			end

			def delete(**options)
			  if(options[:global])
			  	path = self.create_path("global")
			    Dir.each_child(path) {|note| File.delete("#{path}/#{note}") }
			  else 
			  	path = self.create_path(name)
			  	raise "Ingrese nombre del libro a borrar" if name.nil?
			  	raise "No existe el libro con nombre '#{name}'" unless File.exist?(path) 
			    if (name.eql? "global")  
			    	raise  "No se puede eliminar la carpeta 'global'"
			    else
			    	FileUtils.rm_rf(path)			    	
			 	end
			  end
			end

			def self.list(*)
	          Dir.glob("#{Validator.my_rns}/**").map{|book| book.gsub("#{Validator.my_rns}/","")}				
			end

			def rename(new_name, **)
			  old_path = self.create_path(name)
			  new_path = self.create_path(new_name)
	       	  #Si el titulo posee barras o astericos retorna error.
	       	  raise "El nombre posee caracteres inválidos" if Validator.validate_name(new_name)
			  raise  "No se puede modificar la carpeta global" if (name.eql? "global") 
			  Dir.exist?(new_path) ? (raise "El libro con nombre '#{new_name}' ya existe" ) : File.rename(old_path, new_path)
			end
		end
	end
end
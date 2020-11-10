require 'fileutils'
module RN
	module Models
		class Book
			extend RN::Models::Validator
			private
			def self.create_path(book)
				return "#{Validator.my_rns}/#{book}"
			end
			
			def self.create(name, **)
				begin
		          #Si el titulo posee barras o astericos retorna error.
		          raise "El nombre posee caracteres inválidos" if Validator.validate_name(name)
				  Dir.mkdir(self.create_path(name))
				rescue Errno::EEXIST
				  warn "El libro con nombre '#{name}' ya existe"
				  return :exist
				rescue RuntimeError => e
				  warn e.message
				  return :error
				else
				  puts "El libro '#{name}' fue creado con exito"
				end 
			end

			def self.confirmar(path,book)
				puts (book.eql? "global") ? "¿Vaciar libro global ubicado en #{path}?" : "¿Eliminar libro ubicado en #{path}?"
				puts "Si / No"
				opcion = $stdin.gets.chomp
				return opcion.downcase == "si"
			end

			def self.delete(name=nil,**options)
				begin
				  if(options[:global])
				  	path = self.create_path("global")
				  	if(self.confirmar(path,"global"))
				    	Dir.each_child(path) {|note| File.delete("#{path}/#{note}") }
				    else
				    	raise "No se borró el libro"
					end
				  else 
				  	path = self.create_path(name)
				  	raise "Ingrese nombre del libro a borrar" if name.nil?
				  	raise "No existe el libro con nombre '#{name}'" unless File.exist?(path) 
				    if (name.eql? "global")  
				    	raise  "No se puede eliminar la carpeta 'global'"
				    else
					  	if(self.confirmar(path,name))
				    		FileUtils.rm_rf(path)
				    	else
				    		raise "No se borró el libro"
						end				    	
				 	end
				  end
				rescue RuntimeError => e
				  warn e.message
				  return :error_1
				rescue
				  warn "ocurrio un error"
				  raise
				  return :error_n
				else
				  puts options[:global] ? "Vaciando carpeta global" : "Eliminando libro con nombre '#{name}'" 
				end
			end

			def self.list(*)
	          puts "Listando libros: "
	          Dir.glob("#{Validator.my_rns}/**").map{|book| puts book.gsub("#{Validator.my_rns}/",""), :red}				
			end

			def self.rename(old_name, new_name, **)
				begin
				  old_path = self.create_path(old_name)
				  new_path = self.create_path(new_name)
		       	  #Si el titulo posee barras o astericos retorna error.
		       	  raise "El nombre posee caracteres inválidos" if Validator.validate_name(new_name)
				  raise  "No se puede modificar la carpeta global" if (old_name.eql? "global") 
				  Dir.exist?(new_path) ? (raise "El libro con nombre '#{new_name}' ya existe" ) : File.rename(old_path, new_path)
				rescue RuntimeError => e
				  warn e.message
				  return :exist
				rescue Errno::ENOENT
				  warn "El libro que quiere modificar no existe"
				  return :not_exist
				rescue
				  warn "Ha ocurrido un error"
				  raise
				else
				  puts "El libro '#{old_name}' ahora se llama '#{new_name}'"
				end 
			end
		end
	end
end
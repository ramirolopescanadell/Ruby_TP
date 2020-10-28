require 'fileutils'
module RN
  module Commands
    module Books
      class Create < Dry::CLI::Command
        desc 'Create a book'

        argument :name, required: true, desc: 'Name of the book'

        example [
          '"My book" # Creates a new book named "My book"',
          'Memoires  # Creates a new book named "Memoires"'
        ]

        def call(name:, **)
          begin
            name = name.gsub("/", "_")
            Dir.mkdir(".my_rns/#{name}")
          rescue Errno::EEXIST
            warn "El libro con nombre '#{name}' ya existe"
            return :exist
          rescue
            warn "Ha ocurrido un error"
            raise
          else
            puts "El libro '#{name}' fue creado con exito"
          end 
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a book'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'

        example [
          '--global  # Deletes all notes from the global book',
          '"My book" # Deletes a book named "My book" and all of its notes',
          'Memoires  # Deletes a book named "Memoires" and all of its notes'
        ]

        def call(name: nil, **options)
          begin
            if(options[:global])
              path = ".my_rns/global"
              Dir.each_child(path) {|note| File.delete("#{path}/#{note}") }
            else 
              (name.eql? "global") ? (raise  "CantDeleteGlobal") : FileUtils.rm_rf(".my_rns/#{name}")
            end
          rescue RuntimeError
            warn "No se puede eliminar la carpeta 'global' "
            return :error_1
          rescue
            warn "ocurrio un error"
            raise
            return :error_n
          else
            puts options[:global] ? "Vaciando carpeta global" : "Eliminando libro con nombre '#{name}'" 
          end
        end
      end

      class List < Dry::CLI::Command
        desc 'List books'

        example [
          '          # Lists every available book'
        ]

        def call(*)
          puts "Listando libros: "
          puts Dir.glob(".my_rns/**").map{|book| book.gsub(".my_rns/","")} 
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a book'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        example [
          '"My book" "Our book"         # Renames the book "My book" to "Our book"',
          'Memoires Memories            # Renames the book "Memoires" to "Memories"',
          '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
        ]

        def call(old_name:, new_name:, **)
          begin
            old_path = ".my_rns/#{old_name}"
            new_path = ".my_rns/#{new_name}"
            name = new_name.gsub("/", "_")
            raise  "No se puede modificar la carpeta global" if (name.eql? "global") 
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
end

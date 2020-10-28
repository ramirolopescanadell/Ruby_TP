module RN
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        desc 'Create a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Creates a note titled "todo" in the global book',
          '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
          'thoughts --book Memoires    # Creates a note titled "thoughts" in the book "Memoires"'
        ]

        def call(title:, **options)
          #Si no llegó libro por parametro entonces uso el global
          book = options[:book].nil? ? "global" : options[:book]

          #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
          return warn "El libro '#{book}' no existe " unless File.directory?(".my_rns/#{book}")
          
          #Removiendo las barras para que no cree archivos en subdirectorios que no existen.
          title = title.gsub("/", "_")

          path = ".my_rns/#{book}/#{title}"
          if( File.exist?(path))
            warn "La nota con nombre '#{title}' ya exista, elija otro nombre"
          else
            warn "creando nota con nombre '#{title}' en libro '#{book}'"
            system("vim",path)
          end        
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Deletes a note titled "todo" from the global book',
          '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)

          #Si no llegó libro por parametro entonces uso el global
          book = options[:book].nil? ? "global" : options[:book]

          #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
          return warn "El libro '#{book}' no existe " unless File.directory?(".my_rns/#{book}")
          
          path = ".my_rns/#{book}/#{title}"
          if( File.exist?(path))
            warn "Eliminando la nota con nombre '#{title}' en libro '#{book}'"
            File.delete(path)
          else
            warn "La nota con nombre '#{title}' en el libro '#{book}' no existe"
          end 
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Edits a note titled "todo" from the global book',
          '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Edits a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          #Si no llegó libro por parametro entonces uso el global
          book = options[:book].nil? ? "global" : options[:book]

          #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
          return warn "El libro '#{book}' no existe " unless File.directory?(".my_rns/#{book}")
          path = ".my_rns/#{book}/#{title}"
          
          if( File.exist?(path))
            warn "Editando nota con nombre '#{title}'"
            system("vim",path)
          else
            warn "No existe una nota llamada '#{title}' en el libro '#{book}'"
          end        
        end
      end

      class Retitle < Dry::CLI::Command
        desc 'Retitle a note'

        argument :old_title, required: true, desc: 'Current title of the note'
        argument :new_title, required: true, desc: 'New title for the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo TODO                                 # Changes the title of the note titled "todo" from the global book to "TODO"',
          '"New note" "Just a note" --book "My book" # Changes the title of the note titled "New note" from the book "My book" to "Just a note"',
          'thoughts thinking --book Memoires         # Changes the title of the note titled "thoughts" from the book "Memoires" to "thinking"'
        ]

        def call(old_title:, new_title:, **options)
          #Si no llegó libro por parametro entonces uso el global
          book = options[:book].nil? ? "global" : options[:book]

          #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
          return warn "El libro '#{book}' no existe " unless File.directory?(".my_rns/#{book}")

          old_path = ".my_rns/#{book}/#{old_title}"
          
          if(File.exist?(old_path))
            #Removiendo las barras para que no cree archivos en subdirectorios que no existen.
            new_title = new_title.gsub("/", "_")

            new_path = ".my_rns/#{book}/#{new_title}"
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
      end

      class List < Dry::CLI::Command
        desc 'List notes'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'List only notes from the global book'

        example [
          '                 # Lists notes from all books (including the global book)',
          '--global         # Lists notes from the global book',
          '--book "My book" # Lists notes from the book named "My book"',
          '--book Memoires  # Lists notes from the book named "Memoires"'
        ]

        def call(**options)
          book = options[:book]
          global = options[:global]
          #warn "TODO: Implementar listado de las notas del libro '#{book}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          puts Dir.glob(".my_rns/#{book}**/*").map{|note| note.gsub(".my_rns/", " ")}   
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Shows a note titled "todo" from the global book',
          '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          #Si no llegó libro por parametro entonces uso el global
          book = options[:book].nil? ? "global" : options[:book]
          
          #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
          return warn "El libro '#{book}' no existe " unless File.directory?(".my_rns/#{book}")
          
          path = ".my_rns/#{book}/#{title}"
          
          if(File.exist?(path))
            puts File.read(path)
          else
            warn "La nota '#{title}' no existe"
          end
        end
      end
    end
  end
end

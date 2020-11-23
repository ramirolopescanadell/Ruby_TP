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
          bookName = options[:book].nil? ? "global" : options[:book]
          book = RN::Models::Book.new(bookName)  
          note = RN::Models::Note.new(title,book.name)  
          #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
          return warn "El libro '#{book.name}' no existe " unless book.exist?
          #Si el titulo posee barras o astericos retorna error.
          return warn "El nombre posee caracteres inválidos" if note.validate
          puts note.create        
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
          bookName = options[:book].nil? ? "global" : options[:book]
          book = RN::Models::Book.new(bookName)  
          note = RN::Models::Note.new(title,book.name)  
          #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
          return warn "El libro '#{book.name}' no existe " unless book.exist?
          puts note.delete
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
          bookName = options[:book].nil? ? "global" : options[:book]
          book = RN::Models::Book.new(bookName)  
          note = RN::Models::Note.new(title,book.name)  
          #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
          return warn "El libro '#{book.name}' no existe " unless book.exist?
          puts note.edit
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
          bookName = options[:book].nil? ? "global" : options[:book]
          book = RN::Models::Book.new(bookName)  
          note = RN::Models::Note.new(old_title,book.name)  
          #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
          return warn "El libro '#{book.name}' no existe " unless book.exist?
          puts note.retitle(new_title)
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
          RN::Models::Note.list(**options)
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
          bookName = options[:book].nil? ? "global" : options[:book]
          book = RN::Models::Book.new(bookName)  
          note = RN::Models::Note.new(title,book.name)  
          #Si el libro seleccionado no existe entonces finaliza la funcion y muestra un error
          return warn "El libro '#{book.name}' no existe " unless book.exist?
          puts note.show
        end
      end
    end
  end
end

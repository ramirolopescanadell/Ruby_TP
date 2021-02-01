module NotesHelper
	require 'redcarpet'
	def format (content)
    	markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    	markdown.render(content )
  	end
end

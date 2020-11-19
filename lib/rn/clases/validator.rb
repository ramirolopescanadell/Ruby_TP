module RN
	module Models
		module Validator
			@@my_rns = "#{Dir.home}/.my_rns"	
			
			def self.my_rns
        		FileUtils.mkdir_p(@@my_rns) unless File.directory?(@@my_rns)
        		FileUtils.mkdir_p("#{@@my_rns}/global") unless File.directory?("#{@@my_rns}/global")
				@@my_rns
			end	

			def self.validate_name(name)
				return !(name.match? /^[A-Za-z0-9\s]+$/)
			end
		end
	end
end
module RN
	module Models
		module Validator
			@@my_rns = "#{Dir.home}/.my_rns";

			def self.my_rns
				@@my_rns
			end			
			
			def self.validate_name(name)
				return !(name.match? /^[A-Za-z0-9\s]+$/)
			end
		end
	end
end
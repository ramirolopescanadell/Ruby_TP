module RN
	@@my_rns = "#{Dir.home}/.my_rns";

	def self.my_rns
		@@my_rns
	end

	module Models
		module Validator
			def self.validate_name(name)
				return name.match? /\/|\*/
			end
		end
	end
end
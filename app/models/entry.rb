class Entry < ActiveRecord::Base
	validates_presence_of :input, message: "*Entry can't be blank"
end

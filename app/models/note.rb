class Note < ActiveRecord::Base
	belongs_to :user
	belongs_to :message
	has_many :attachments
end

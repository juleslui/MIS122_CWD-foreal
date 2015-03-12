class Message < ActiveRecord::Base
	belongs_to :office
	has_many :notes
	mount_uploader :avatars, AttacherUploader
end

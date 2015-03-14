class Attachment < ActiveRecord::Base
	belongs_to :note
	mount_uploader :file, AttacherUploader
end

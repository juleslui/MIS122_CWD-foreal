class Message < ActiveRecord::Base
	belongs_to :office
	has_many :notes
	has_many :attachments, :through => :notes
	has_many :revisions
	accepts_nested_attributes_for :notes
end

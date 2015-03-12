class Office < ActiveRecord::Base
	acts_as_messageable
	has_many :messages
	has_many :users

  def display_name
  	return :name
  end

  def mailboxer_email(object)
  #Check if an email should be sent for that object
  #if true
  	return :email
  #if false
  #return nil
  end
end

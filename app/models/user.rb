class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :office
  acts_as_messageable

  def display_name
  	fullname = "#{:last_name}, #{:first_name} #{:middle_initial}"
  	return fullname
  end

  def mailboxer_email(object)
  #Check if an email should be sent for that object
  #if true
  	return :email
  #if false
  #return nil
  end
end

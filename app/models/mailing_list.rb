class MailingList < ActiveRecord::Base

  acts_as_indexed :fields => [:email, :password]

  validates :email, :presence => true, :uniqueness => true
  
end

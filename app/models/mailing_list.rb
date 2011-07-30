class MailingList < ActiveRecord::Base

  acts_as_indexed :fields => [:email]

  validates :email, :presence => true, :uniqueness => true
  
end

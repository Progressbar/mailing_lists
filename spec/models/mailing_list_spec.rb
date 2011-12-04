require 'spec_helper'

describe MailingList do

  def reset_mailing_list(options = {})
    @valid_attributes = {
      :id => 1,
      :email => "RSpec is great for testing too"
    }

    @mailing_list.destroy! if @mailing_list
    @mailing_list = MailingList.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_mailing_list
  end

  context "validations" do
    
    it "rejects empty email" do
      MailingList.new(@valid_attributes.merge(:email => "")).should_not be_valid
    end

    it "rejects non unique email" do
      # as one gets created before each spec by reset_mailing_list
      MailingList.new(@valid_attributes).should_not be_valid
    end
    
  end

end
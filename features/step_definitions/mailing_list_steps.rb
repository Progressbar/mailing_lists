Given /^I have no mailing_lists$/ do
  MailingList.delete_all
end

Given /^I (only )?have mailing_lists titled "?([^\"]*)"?$/ do |only, titles|
  MailingList.delete_all if only
  titles.split(', ').each do |title|
    MailingList.create(:email => title)
  end
end

Then /^I should have ([0-9]+) mailing_lists?$/ do |count|
  MailingList.count.should == count.to_i
end

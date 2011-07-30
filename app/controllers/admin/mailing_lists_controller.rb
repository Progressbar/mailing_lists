module Admin
  class MailingListsController < Admin::BaseController

    crudify :mailing_list,
            :title_attribute => 'email', :xhr_paging => true

  end
end

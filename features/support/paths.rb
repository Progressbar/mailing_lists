module NavigationHelpers
  module Refinery
    module MailingLists
      def path_to(page_name)
        case page_name
        when /the list of mailing_lists/
          admin_mailing_lists_path

         when /the new mailing_list form/
          new_admin_mailing_list_path
        else
          nil
        end
      end
    end
  end
end

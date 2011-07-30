require 'refinerycms-base'

module Refinery
  module MailingLists
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "mailing_lists"
          plugin.activity = {
            :class => MailingList,
            :title => 'email'
          }
        end
      end
    end
  end
end

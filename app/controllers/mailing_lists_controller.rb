class MailingListsController < ApplicationController

  before_filter :find_all_mailing_lists
  before_filter :find_page

  require 'net/http'

  GENERAL_MAILING_LIST_URL = 'http://lists.progressbar.sk/mailman/listinfo/general-discussion'
  GENERAL_MAILING_LIST_SUBSCRIBE_URL = 'http://lists.progressbar.sk/mailman/subscribe/general-discussion'
  GENERAL_MAILING_LIST_UNSUBSCRIBE_URL = 'http://lists.progressbar.sk/mailman/options/general-discussion'

  EVENTS_MAILING_LIST_URL = 'http://lists.progressbar.sk/mailman/listinfo/events'
  EVENTS_MAILING_LIST_SUBSCRIBE_URL = 'http://lists.progressbar.sk/mailman/subscribe/events'
  EVENTS_MAILING_LIST_UNSUBSCRIBE_URL = 'http://lists.progressbar.sk/mailman/options/events'

  def index
    subscriber = MailingList.find_by_email(@mailing_list[:email])
    # if subscriber not exits we create new and subcribe him where they want
    if subscriber.nil? 
      if params[:mailing_list] && @mailing_list.valid?
        self.subscribe_to_general if @mailing_list.general
        self.subscribe_to_events if @mailing_list.events

        @mailing_list.save
        redirect_to :action => 'index'
      end
    else
      # otherwise we try subscribe or unsubscribe him from what they want
      if @mailing_list[:general]
        if subscriber[:general]
          subscriber.update_attributes(:general => false)
          redirect_to GENERAL_MAILING_LIST_UNSUBSCRIBE_URL
        else
          subscriber.update_attributes(:general => true) if self.subscribe_to_general
          redirect_to :action => 'index'
        end
      else
        if @mailing_list[:events]
          if subscriber[:events]
            subscriber.update_attributes(:events => false)
            redirect_to EVENTS_MAILING_LIST_UNSUBSCRIBE_URL
          else
            subscriber.update_attributes(:events => true) if self.subscribe_to_events
            redirect_to :action => 'index'
          end
        end
      end
    end
  end

  protected

  def subscribe_to_general
    gr = self.subscribe(GENERAL_MAILING_LIST_SUBSCRIBE_URL)
    if gr.code.to_i == 200
      flash[:success] = t('.general_mailinglist_subscription_success')
    else
      flash[:error] = t('.general_mailinglist_subscription_error')
    end
    gr.code.to_i == 200
  end

  def subscribe_to_events
    er = self.subscribe(EVENTS_MAILING_LIST_SUBSCRIBE_URL)
    if er.code.to_i == 200
      flash[:success] = t('.events_mailinglist_subscription_success')
    else
      flash[:error] = t('.events_mailinglist_subscription_error')
    end
    er.code.to_i == 200
  end

  def subscribe(url)
    url = URI.parse(url)
    post_args = {
      'email' => @mailing_list.email
    }

    Net::HTTP.post_form(url, post_args)
  end

  def find_all_mailing_lists
    @mailing_lists = MailingList.order('position ASC')
  end

  def find_page
    @page = Page.where(:link_url => "/mailing_lists").first
  end
end

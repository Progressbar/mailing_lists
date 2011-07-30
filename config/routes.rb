::Refinery::Application.routes.draw do

  resources :mailing_lists, :only => [:index] do
    collection do
      post :index
    end
  end

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :mailing_lists, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end

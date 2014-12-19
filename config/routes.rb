Exchange::Application.routes.draw do

  # Root

  root :to => "static_pages#home"

  # Status

  get :status, to: lambda { head :ok }

  # Gems

  use_doorkeeper do
    skip_controllers :applications
  end

  mount OpenStax::Accounts::Engine, at: "/accounts"
  mount FinePrint::Engine, at: "/fine_print"

  # Administrator

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Agent

  namespace 'manage' do
    get '/', to: 'base#index'

    user_routes :agents

    application_routes :platforms
    application_routes :subscribers
  end

  # Researcher

  namespace 'research' do
    get '/', to: 'base#index'

    resources :events, only: :index
    resources :activities, only: :index
  end

  # JSON API

  apipie

  api :v1, :default => true do
    resources :people, only: :create

    resources :events, only: :index

    scope '/events' do
      scope '/identifiers' do
        event_routes :pages
        event_routes :heartbeats
        event_routes :cursors
        event_routes :inputs
      end

      scope '/platforms' do
        event_routes :answers
        event_routes :gradings
        event_routes :messages
        event_routes :taskings
      end
    end

    resources :activities, only: :index
  end

  # Shared Pages

  # Resources

  resources :terms, only: [:index, :show] do
    collection do
      get 'pose'
      post 'agree'
    end
  end

  # Singular routes
  # Only for routes with unique names

  scope module: 'static_pages' do
    get 'api'
    get 'copyright'
    get 'about'
  end

end

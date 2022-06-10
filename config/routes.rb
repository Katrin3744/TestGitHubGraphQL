Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :user, constraints: { format: 'json' } do
    get '/:login', to: 'repositories#index'
    get '/:login/:repo', to: 'commits#index'
  end
end

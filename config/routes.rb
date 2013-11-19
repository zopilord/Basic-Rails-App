Bloccit::Application.routes.draw do
	resources :topics do
		resources :posts, except: [:index] do
			resources :comments, only: [:create, :destroy]
				match '/up-vote', to: 'votes#up_vote', as: :up_vote
				match '/down-vote', to: 'votes#down_vote', as: :down_vote
		end		
	end
		
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

	match "about" => "welcome#about", via: :get

  root to: 'welcome#index'
end

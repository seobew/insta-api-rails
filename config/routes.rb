Rails.application.routes.draw do
  get 'users/self', to: 'users#own'

  get 'users/:user_id', to: 'users#individual'

  get 'users/self/media/recent', to: 'users#own_media'

  get 'users/:user_id/media/recent', to: 'users#individual_media'

  get 'users/self/follows', to: 'users#self_follow'

  get 'users/self/followed-by', to: 'users#self_followed_by'

  get 'users/self/requested-by', to: 'users#self_requested_by'

  get 'media/:media_id', to: 'media#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

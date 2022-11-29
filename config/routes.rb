Rails.application.routes.draw do
  resources :teams do
    resources :categories, only: %i[new create], shallow: true
    resources :tasks, shallow: true do
      resources :comments, only: %i[create destroy]
    end
  end

  root 'teams#index'

  devise_for :users, controllers: {
    invitations: 'users/invitations',
    registrations: 'users/registrations'
  }
  resources :users, only: :show

  # letter_opener
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

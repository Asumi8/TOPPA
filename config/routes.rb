Rails.application.routes.draw do
  resources :tasks
  resources :teams do
    resources :tasks, shallow: true
  end

  root 'teams#index'

  devise_for :users, controllers: {
    invitations: 'users/invitations'
  }
  resources :users, only: :show

  # letter_opener
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

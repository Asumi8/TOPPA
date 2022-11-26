Rails.application.routes.draw do
  resources :teams

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

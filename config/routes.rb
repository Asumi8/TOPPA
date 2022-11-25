Rails.application.routes.draw do
  devise_for :users
  root 'teams#index'
  resources :teams

  
  resources :users, only: :show

  # letter_opener
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :teams do
    member do
      get 'mvp'
    end
    resources :categories, only: %i[new create], shallow: true
    resources :tasks, shallow: true do
      resources :comments, only: %i[create destroy]
    end
  end

  root 'top#index'

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/admin_sign_in', to: 'users/sessions#admin_sign_in'
  end

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

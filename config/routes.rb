Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :teams do
    member do
      get 'mvp'
      delete 'mvp_delete'
      delete 'assign_delete'
    end
    resources :categories, only: %i[new create], shallow: true
    resources :tasks, shallow: true do
      member { patch 'update_status' => 'tasks#update_status' }
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
  resources :users, only: :show do
    collection do
      get 'app'
    end
  end

  # letter_opener
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

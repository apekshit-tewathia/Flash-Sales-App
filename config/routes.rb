Rails.application.routes.draw do
  root to: 'deals#index'
  resources :users, only: [:edit, :show, :update, :destroy]

  controller :verification do
    get 'verify/:verification_token' => :verify, as: :verify_user
  end

  controller :registration do
    get 'sign-up' => :new
    post 'sign-up' => :create
  end

  resource :password, only: [:new, :edit, :update] do
    get 'user-forgot-password-mail-sent' => :forgot_password_verify_email, as: :verify_email_for_forgot
  end

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end

  controller :checkout do
    post 'checkout'
    get 'success'
    get 'cancel'
  end

  namespace :admin do
    resources :deals
    resources :users, only: [:index, :new, :create]
    resources :orders, only: :index do
      patch 'mark_status'
    end
  end

  resources :deals, only: [:index, :show]

  resources :orders do
    post 'checkout', on: :member
    patch 'cancel'
  end

  resources :line_items

  scope :user do
    resources :address do
      patch 'shipping', on: :collection
    end
  end
end

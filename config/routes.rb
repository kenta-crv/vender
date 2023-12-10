Rails.application.routes.draw do
  #取引先アカウント
  devise_for :clients, controllers: {
    registrations: 'clients/registrations',
    sessions: 'clients/sessions'
  }
  resources :clients, only: [:show] do
    member do
      post :disclose
    end
  end

  #管理者アカウント
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }
  resources :admins, only: [:show]

  root to: 'top#index' #トップページ
  #特集
  get 'faq' => 'top#faq'
  get 'co' => 'top#co'
  get 'question' => 'top#question'

  get 'old' => 'top#old'
  get 'inside' => 'top#inside'
  get 'outside' => 'top#outside'
  get 'both' => 'top#both'

  get 'lp' => 'top#lp'

  get 'cocacola' => 'top#cocacola'
  get 'suntory' => 'top#suntory'
  get 'asahi' => 'top#asahi'
  get 'otsuka' => 'top#otsuka'
  get 'itoen' => 'top#itoen'
  get 'dydo' => 'top#dydo'
  get 'kirin' => 'top#kirin'

  get 'neos' => 'estimates#neos'

  get 'question' => 'top#question'
  get 'business' => 'top#business'
  get 'corporation' => 'top#corporation'  #会社概要
  get 'privacy' => 'top#privacy' #プライバシーポリシー

  resources :columns do
    collection do 
      post :import
    end
  end
  resources :questions

  resources :estimates do
    resources :progresses
    resources :comments  do
     member do
       post :update_status
     end
    end
    resources :transfers
    collection do
      post :confirm
      post :thanks
      post :import
    end
    member do
      post :send_mail_cfsl
      post :send_mail
      get :select_sent
      get :confirm_point
      post 'old_email', to: 'estimates#old_email', as: 'old_email'
      post 'outside_email', to: 'estimates#outside_email', as: 'outside_email'
      post 'share_email', to: 'estimates#share_email', as: 'share_email'
    end
  end
  get 'contract' => 'estimates#contract'
  get 'sfa' => 'estimates#sfa'
  get 'payment' => 'estimates#payment'
  post 'estimates/client_select', to: 'estimates#client_select', as: 'client_select_estimate'
  get 'estimates/:id/accept', to: 'estimates#accept', as: 'accept_estimate'
  get 'estimates/:id/decline', to: 'estimates#decline', as: 'decline_estimate'

  # メッセージ
  resources :messages, only: [:create] do
    collection do
      # メッセージルーム
      get :room, path: '/room/:uri_token'
    end
  end

  #企業側アカウント
  #resource :company, only: [:show, :edit, :update] do
    # imagesに関するルーティング
   # resources :images, only: [:create, :destroy, :update, :download, :edit] do
    #  get 'view', on: :member
     # get 'download/:id', action: :download, as: :pdf, on: :member
    #end
  #end
  resources :companies

  #get '*path', controller: 'application', action: 'render_404'
end

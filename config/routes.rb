Rails.application.routes.draw do

  devise_for :clients, controllers: {
    registrations: 'clients/registrations',
    sessions: 'clients/sessions'
  }
  resources :clients, only: [:show]
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

  get 'cocacola' => 'top#cocacola'
  get 'suntory' => 'top#suntory'
  get 'asahi' => 'top#asahi'
  get 'otsuka' => 'top#otsuka'
  get 'itoen' => 'top#itoen'
  get 'dydo' => 'top#dydo'
  get 'kirin' => 'top#kirin'

  get 'question' => 'top#question'
  get 'corporation' => 'top#corporation'  #会社概要
  get 'privacy' => 'top#privacy' #プライバシーポリシー

  resources :columns

  resources :estimates do
    resources :progresses
    resources :comments
    collection do
      post :confirm
      post :thanks
    end
    member do
      get :apply
      post :send_mail
      get :confirm_point
      post :apply
    end
  end
  get 'contract' => 'estimates#contract'

  # メッセージ
  resources :messages, only: [:create] do
    collection do
      # メッセージルーム
      get :room, path: '/room/:uri_token'
    end
  end

  #企業側アカウント
  resources :companies do
    resources :images, only: [:create, :destroy, :update, :download, :edit]
      member do
        get 'images/view'
        get 'images/download/:id' => 'images#download' ,as: :images_pdf
      end
    collection do
      get :pay
      post :get_point
      post :confirm
      post :thanks
    end
  end


  #get '*path', controller: 'application', action: 'render_404'
end

Rails.application.routes.draw do
    
    # Deviseのルーティング
    devise_for :users, controllers: { registrations: 'registrations' }
    
    get 'rooms/search', to: 'rooms#search', as: 'search_rooms'

    resources :rooms do
      resources :reservations, only: [:new, :create] do
         collection do
           post 'confirm'
         end
       end
     end




    # ユーザー関連
    resources :users, only: [:show] do
      member do
        get 'edit_account'
        patch 'update_account'
        get 'edit_profile', to: 'users#edit_profile', as: 'edit_profile'
        patch 'update_profile'
        get 'account'
        get 'profile'
      end
    end
   
   
    # resources :rooms, only: [:show]
    resources :rooms

    # その他の独自ルーティング
    get 'tokyo_rooms', to: 'rooms#tokyo_index', as: 'tokyo_rooms'
    get 'osaka_rooms', to: 'rooms#osaka_index', as: 'osaka_rooms'
    get 'kyoto_rooms', to: 'rooms#kyoto_index', as: 'kyoto_rooms'
    get 'sapporo_rooms', to: 'rooms#sapporo_index', as:'sapporo_rooms'

  
    # トップページ
    root 'pages#home'
  
    # 施設関連
    # config/routes.rb
    
  
    # 予約関連
    resources :reservations, only: [:index, :show]


end
  




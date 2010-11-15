Twentyone::Application.routes.draw do
  root :to => "habit#view"
  match 'login' => "home#login"
  match 'habit/create' => "habit#create"
  match 'habit/toggle_today' => "habit#toggle_today"
  match 'habit/cancel' => "habit#cancel"
  match 'friends' => "friend#index"
  namespace 'admin' do
    root :to => "admin#index"
    resources :user, :only => [:index, :show]
    resources :habit, :only => [:index, :show]
  end
end

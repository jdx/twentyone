Twentyone::Application.routes.draw do
  root :to => "home#index"
  match 'login' => "home#login"
  match 'logout' => "home#logout"
  match 'auth/facebook' => "facebook#login"
  match 'facebook/link' => "facebook#link"
  match 'auth/facebook/callback' => "facebook#callback"
  match 'habit' => "habit#view"
  match 'habit/create' => "habit#create"
  match 'habit/toggle_today' => "habit#toggle_today"
  match 'habit/cancel' => "habit#cancel"
  match 'friends' => "friend#index"
  match 'twilio/sms' => 'twilio#sms'
  match 'notifications/send' => 'notifications#send_all'
  match 'notification/edit' => 'notifications#edit'
  namespace 'admin' do
    root :to => "admin#index"
    resources :user, :only => [:index, :show]
    resources :habit, :only => [:index, :show]
  end
end

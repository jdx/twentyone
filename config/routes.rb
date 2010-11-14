Twentyone::Application.routes.draw do
  root :to => "home#index"
  match 'login' => "home#login"
  match 'habit/create' => "habit#create"
  match 'habit/' => "habit#view"
  match 'habit/today' => "habit#today"
end

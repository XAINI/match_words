Rails.application.routes.draw do

  resources :match_words do
    post :insert, on: :collection
    get :display_words, on: :collection
  end

end

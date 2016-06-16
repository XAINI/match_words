Rails.application.routes.draw do

  resources :match_words do
    post :insert, on: :collection
  end

end

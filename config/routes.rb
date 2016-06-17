Rails.application.routes.draw do

  resources :match_words do
    get :display_words, on: :collection
  end

end

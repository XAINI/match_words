Rails.application.routes.draw do

  resources :match_words do
    post :insert_word_list, on: :collection
    delete :delete_word, on: :collection
  end

end

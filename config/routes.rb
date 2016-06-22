Rails.application.routes.draw do

  resources :match_words do
    collection do
      get 'insert_word'
      post 'insert_word_list'
      delete 'delete_word'
      get 'article'
      post 'article_insert'
      post 'analysis_article'
    end
  end

end

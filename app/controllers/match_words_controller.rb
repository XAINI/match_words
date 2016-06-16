class MatchWordsController < ApplicationController
  def index
    
  end

  def insert
    fetch_value = params[:fetched_value]
    word_list = RegExp_split_words(fetch_value)
    word_list.each do |word|
      data = MatchWord.create(:word => word)
      if data.save
        redirect_to "/match_words"
      else
        redirect_to "/match_words"
      end
    end
  end

  def display_words
    
  end

  private
    def RegExp_split_words(str)
      data = []
      pattern = /^[a-zA-Z]+/
      items = str.scan(pattern)
      items.each_with_index do |item|
        data.push(item)
      end
      data
    end
end